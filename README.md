# Recruitment & Hiring Analytics System

An end-to-end recruitment analytics project that analyzes hiring performance, recruitment funnels, recruiter efficiency, sourcing channels, salary trends, candidate skills, and hiring outcomes.

## 🎯 Business Objective

Recruitment teams need to understand where candidates come from, how efficiently they move through the hiring funnel, which roles are hardest to fill, and which factors are associated with successful hiring.

This project converts raw recruitment data into actionable insights using SQL, Python, Power BI, Machine Learning, NLP, and AWS.

## 🛠️ Tech Stack

- **SQL / PostgreSQL** – Data storage, joins, aggregations, funnel and business analysis
- **Python** – Data cleaning, EDA, statistical analysis and visualization
- **Power BI** – Interactive recruitment dashboards and KPI reporting
- **Machine Learning** – Hiring outcome prediction and feature analysis
- **NLP** – Candidate skill frequency and skill-to-hiring analysis
- **AWS S3 / IAM** – Cloud data storage and access management
- **GitHub** – Version control and project documentation

## 📊 Key Metrics

| Metric | Result |
|---|---:|
| Candidates | 2,000 |
| Applications | 10,000 |
| Interviews | 3,049 |
| Offers | 1,533 |
| Hires | 486 |
| Hiring Conversion | 4.86% |
| Average Time to Hire | 40.22 days |

## 🔍 Key Analysis

### Recruitment Funnel

Applications → Interviews → Offers → Hires

- Application → Interview: **30.49%**
- Interview → Offer: **50.28%**
- Offer → Hire: **31.70%**

### Analysis Areas

- Hiring funnel performance
- Hiring conversion by job role
- Recruitment source effectiveness
- Recruiter performance
- Salary analysis by role
- Monthly application and hiring trends
- Time-to-hire analysis
- Candidate experience and education analysis
- Candidate skill frequency
- Skill-level hiring outcomes

## 🤖 Machine Learning

A hiring outcome prediction model was developed using candidate and job attributes available before the hiring process.

Features include:

- Age
- Experience
- Education
- Job role
- Department
- Employment type
- Recruitment source

The project evaluates Logistic Regression and Random Forest models while accounting for the highly imbalanced hiring outcome.

**Important:** Accuracy is not treated as the primary metric because only a small percentage of applications result in hires.

## 🧠 NLP Analysis

Candidate skill data was processed to identify:

- Most common candidate skills
- Skill distribution
- Hiring rate associated with individual skills
- Reliable skill-level hiring patterns using a minimum application threshold

## 📈 Power BI Dashboard

The Power BI dashboard contains three analytical views:

1. **Executive Overview**
   - Recruitment KPIs
   - Hiring funnel
   - Applications by source and role
   - Source hiring conversion

2. **Hiring Performance**
   - Hiring conversion by role
   - Recruiter performance
   - Salary analysis
   - Monthly application trends
   - Offer-to-hire conversion

3. **Source & Recruitment Analysis**
   - Recruitment source performance
   - Monthly hiring trends
   - Source and role filtering
   - Time-to-hire analysis

## ☁️ AWS

Raw recruitment datasets are stored in an **Amazon S3** bucket with IAM-based access management.

The cloud architecture is designed to support future migration of the PostgreSQL analytics database to AWS.

## 📁 Project Structure

```text
Recruitment-Hiring-Analytics/
│
├── data/
│   └── Raw recruitment datasets
│
├── ml/
│   └── Machine learning and analysis outputs
│
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_ml_model.ipynb
│   └── 03_nlp_analysis.ipynb
│
├── sql/
│   └── analysis.sql
│
└── LICENSE
PROJECT WORKFLOW

Raw Recruitment Data
        ↓
PostgreSQL
        ↓
SQL Analysis
        ↓
Python EDA
        ↓
Power BI Dashboard
        ↓
Machine Learning
        ↓
NLP Skill Analysis
        ↓
AWS Cloud Storage

BUSINESS VALUE

The project demonstrates how recruitment data can be transformed into actionable insights for:

Improving hiring funnel efficiency
Identifying effective recruitment channels
Comparing recruiter performance
Understanding role-level hiring patterns
Monitoring hiring costs and salary trends
Identifying valuable candidate skill patterns
Supporting data-driven recruitment decisions
