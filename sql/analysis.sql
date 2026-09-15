-- =====================================================
-- RECRUITMENT & HIRING ANALYTICS
-- SQL ANALYSIS
-- =====================================================


-- Q1. Total number of candidates
SELECT COUNT(*) AS total_candidates
FROM candidates;


-- Q2. Total number of applications
SELECT COUNT(*) AS total_applications
FROM applications;


-- Q3. Which job roles received the most applications?
SELECT
    j.job_title,
    COUNT(a.application_id) AS total_applications
FROM applications a
JOIN jobs j
    ON a.job_id = j.job_id
GROUP BY j.job_title
ORDER BY total_applications DESC;


-- Q4. Which recruitment sources generated the most applications?
SELECT
    s.source_name,
    COUNT(a.application_id) AS total_applications
FROM applications a
JOIN sources s
    ON a.source_id = s.source_id
GROUP BY s.source_name
ORDER BY total_applications DESC;

-- Q5. Hiring conversion rate by recruitment source

SELECT
    s.source_name,
    COUNT(DISTINCT a.application_id) AS total_applications,
    COUNT(DISTINCT h.hire_id) AS total_hires,
    ROUND(
        COUNT(DISTINCT h.hire_id) * 100.0
        / COUNT(DISTINCT a.application_id),
        2
    ) AS hiring_conversion_rate
FROM applications a
JOIN sources s
    ON a.source_id = s.source_id
LEFT JOIN hires h
    ON a.application_id = h.application_id
GROUP BY s.source_name
ORDER BY hiring_conversion_rate DESC;
-- Q6. Recruitment funnel

SELECT 'Applications' AS stage, COUNT(*) AS candidates
FROM applications

UNION ALL

SELECT 'Interviews', COUNT(DISTINCT application_id)
FROM interviews

UNION ALL

SELECT 'Offers', COUNT(DISTINCT application_id)
FROM offers

UNION ALL

SELECT 'Hires', COUNT(DISTINCT application_id)
FROM hires;
-- Q7. Recruitment funnel conversion rates

WITH funnel AS (
    SELECT 'Applications' AS stage, 1 AS stage_order, COUNT(*) AS candidates
    FROM applications

    UNION ALL

    SELECT 'Interviews', 2, COUNT(DISTINCT application_id)
    FROM interviews

    UNION ALL

    SELECT 'Offers', 3, COUNT(DISTINCT application_id)
    FROM offers

    UNION ALL

    SELECT 'Hires', 4, COUNT(DISTINCT application_id)
    FROM hires
)

SELECT
    stage,
    candidates,
    ROUND(
        candidates * 100.0 /
        FIRST_VALUE(candidates) OVER (ORDER BY stage_order),
        2
    ) AS percentage_of_applications
FROM funnel
ORDER BY stage_order;
-- Q8. Hiring conversion rate by job role

SELECT
    j.job_title,
    COUNT(DISTINCT a.application_id) AS applications,
    COUNT(DISTINCT h.hire_id) AS hires,
    ROUND(
        COUNT(DISTINCT h.hire_id) * 100.0
        / COUNT(DISTINCT a.application_id),
        2
    ) AS hiring_conversion_rate
FROM applications a
JOIN jobs j
    ON a.job_id = j.job_id
LEFT JOIN hires h
    ON a.application_id = h.application_id
GROUP BY j.job_title
ORDER BY hiring_conversion_rate DESC;
-- Q9. Recruitment funnel by job role

SELECT
    j.job_title,

    COUNT(DISTINCT a.application_id) AS applications,

    COUNT(DISTINCT i.application_id) AS interviews,

    COUNT(DISTINCT o.application_id) AS offers,

    COUNT(DISTINCT h.application_id) AS hires

FROM jobs j

LEFT JOIN applications a
    ON j.job_id = a.job_id

LEFT JOIN interviews i
    ON a.application_id = i.application_id

LEFT JOIN offers o
    ON a.application_id = o.application_id

LEFT JOIN hires h
    ON a.application_id = h.application_id

GROUP BY j.job_title

ORDER BY applications DESC;
-- Q10. Funnel conversion rates by job role

WITH funnel AS (

    SELECT
        j.job_title,

        COUNT(DISTINCT a.application_id) AS applications,

        COUNT(DISTINCT i.application_id) AS interviews,

        COUNT(DISTINCT o.application_id) AS offers,

        COUNT(DISTINCT h.application_id) AS hires

    FROM jobs j

    LEFT JOIN applications a
        ON j.job_id = a.job_id

    LEFT JOIN interviews i
        ON a.application_id = i.application_id

    LEFT JOIN offers o
        ON a.application_id = o.application_id

    LEFT JOIN hires h
        ON a.application_id = h.application_id

    GROUP BY j.job_title
)

SELECT
    job_title,
    applications,
    interviews,
    offers,
    hires,

    ROUND(interviews * 100.0 / NULLIF(applications, 0), 2)
        AS application_to_interview_pct,

    ROUND(offers * 100.0 / NULLIF(interviews, 0), 2)
        AS interview_to_offer_pct,

    ROUND(hires * 100.0 / NULLIF(offers, 0), 2)
        AS offer_to_hire_pct

FROM funnel

ORDER BY application_to_interview_pct DESC;
-- Q11. Average time to hire

SELECT
    ROUND(
        AVG(
            h.hire_date - a.application_date
        ),
        2
    ) AS average_days_to_hire
FROM applications a
JOIN hires h
    ON a.application_id = h.application_id;
    -- Q12. Average time-to-hire by job role

SELECT
    j.job_title,
    COUNT(DISTINCT h.hire_id) AS total_hires,
    ROUND(
        AVG(h.hire_date - a.application_date),
        2
    ) AS average_days_to_hire
FROM applications a
JOIN jobs j
    ON a.job_id = j.job_id
JOIN hires h
    ON a.application_id = h.application_id
GROUP BY j.job_title
ORDER BY average_days_to_hire DESC;
-- Q13. Recruiter performance

SELECT
    r.recruiter_name,
    COUNT(DISTINCT a.application_id) AS applications_handled,
    COUNT(DISTINCT h.hire_id) AS total_hires,
    ROUND(
        COUNT(DISTINCT h.hire_id) * 100.0
        / NULLIF(COUNT(DISTINCT a.application_id), 0),
        2
    ) AS hiring_conversion_rate
FROM recruiters r
LEFT JOIN applications a
    ON r.recruiter_id = a.recruiter_id
LEFT JOIN hires h
    ON a.application_id = h.application_id
GROUP BY r.recruiter_id, r.recruiter_name
ORDER BY total_hires DESC;
-- Q14. Rank recruiters by hiring conversion rate

WITH recruiter_performance AS (
    SELECT
        r.recruiter_name,
        COUNT(DISTINCT a.application_id) AS applications_handled,
        COUNT(DISTINCT h.hire_id) AS total_hires,
        ROUND(
            COUNT(DISTINCT h.hire_id) * 100.0
            / NULLIF(COUNT(DISTINCT a.application_id), 0),
            2
        ) AS conversion_rate
    FROM recruiters r
    LEFT JOIN applications a
        ON r.recruiter_id = a.recruiter_id
    LEFT JOIN hires h
        ON a.application_id = h.application_id
    GROUP BY r.recruiter_id, r.recruiter_name
)

SELECT
    recruiter_name,
    applications_handled,
    total_hires,
    conversion_rate,
    RANK() OVER (
        ORDER BY conversion_rate DESC
    ) AS performance_rank
FROM recruiter_performance
ORDER BY performance_rank;
-- Q15. Monthly recruitment trends

SELECT
    DATE_TRUNC('month', a.application_date)::date AS month,
    COUNT(DISTINCT a.application_id) AS applications,
    COUNT(DISTINCT o.application_id) AS offers,
    COUNT(DISTINCT h.application_id) AS hires
FROM applications a
LEFT JOIN offers o
    ON a.application_id = o.application_id
LEFT JOIN hires h
    ON a.application_id = h.application_id
GROUP BY month
ORDER BY month;
-- Q16. Average offered salary by job role

SELECT
    j.job_title,
    COUNT(o.offer_id) AS total_offers,
    ROUND(AVG(o.offered_salary), 2) AS average_offered_salary,
    ROUND(MIN(o.offered_salary), 2) AS minimum_offered_salary,
    ROUND(MAX(o.offered_salary), 2) AS maximum_offered_salary
FROM offers o
JOIN applications a
    ON o.application_id = a.application_id
JOIN jobs j
    ON a.job_id = j.job_id
GROUP BY j.job_title
ORDER BY average_offered_salary DESC;
-- Q17. Recruitment source performance

SELECT
    s.source_name,
    COUNT(DISTINCT a.application_id) AS applications,
    COUNT(DISTINCT h.hire_id) AS hires,
    ROUND(
        COUNT(DISTINCT h.hire_id) * 100.0
        / NULLIF(COUNT(DISTINCT a.application_id), 0),
        2
    ) AS conversion_rate
FROM sources s
LEFT JOIN applications a
    ON s.source_id = a.source_id
LEFT JOIN hires h
    ON a.application_id = h.application_id
GROUP BY s.source_id, s.source_name
ORDER BY hires DESC;
-- Q18. Executive recruitment summary

SELECT
    COUNT(DISTINCT a.application_id) AS total_applications,
    COUNT(DISTINCT i.application_id) AS total_interviews,
    COUNT(DISTINCT o.application_id) AS total_offers,
    COUNT(DISTINCT h.application_id) AS total_hires,

    ROUND(
        COUNT(DISTINCT h.application_id) * 100.0
        / NULLIF(COUNT(DISTINCT a.application_id), 0),
        2
    ) AS overall_hiring_conversion_pct,

    ROUND(
        AVG(h.hire_date - a.application_date),
        2
    ) AS average_days_to_hire

FROM applications a

LEFT JOIN interviews i
    ON a.application_id = i.application_id

LEFT JOIN offers o
    ON a.application_id = o.application_id

LEFT JOIN hires h
    ON a.application_id = h.application_id;
