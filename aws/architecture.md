# AWS Architecture

## Objective

Use AWS for secure cloud storage of raw recruitment data while keeping the project cost at $0.

## Architecture

```text
Recruitment CSV Data
        |
        v
Amazon S3
(recruitment-hiring-analytics-ekansh-2026)
        |
        v
IAM
(RecruitmentS3ReadOnly)

Components
Amazon S3

Stores the 8 raw recruitment CSV files:

applications.csv
candidates.csv
hires.csv
interviews.csv
jobs.csv
offers.csv
recruiters.csv
sources.csv
AWS IAM

Provides controlled read-only access to the S3 bucket through the
RecruitmentS3ReadOnly policy.

Local PostgreSQL

The analytics database remains local:

recruitment_analysis

Local Analytics Stack
SQL
Python
Power BI
Machine Learning
NLP
Cost Strategy

This project intentionally does not provision Amazon RDS, EC2, Lambda,
or other paid infrastructure. AWS is used only for S3 and IAM demonstration,
within the applicable AWS Free Tier/credits.

Security
Root access keys are not used.
S3 access is restricted to the project bucket.
IAM permissions follow read-only access for analytics.
No database passwords or AWS credentials are stored in GitHub.
