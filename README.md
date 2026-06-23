# Complaint Resolution Workflow A/B Testing Analysis

## Project Overview

This project evaluates the effectiveness of a new complaint resolution workflow designed to reduce late complaints. Using an A/B testing framework, complaint cases were divided into a Control Group (existing workflow) and a Treatment Group (enhanced workflow). Statistical testing was performed to determine whether the new workflow significantly reduced the rate of late complaint closures.

The analysis demonstrates how data-driven process improvements can improve operational performance, regulatory compliance, and customer satisfaction.

---

## Business Problem

Organizations often track complaint resolution timeliness to ensure regulatory compliance and customer satisfaction. Complaints exceeding a predefined resolution threshold create operational risks and may indicate process inefficiencies.

In this study, a complaint is considered late if:

```text
Issue Age > 45 Days
```

The objective was to determine whether a redesigned complaint management process could reduce the proportion of late complaints.

---

## Experimental Design

### Control Group (Old Workflow)

The existing workflow included:

* Standard complaint assignment
* Manual monitoring of aging complaints
* Reactive escalation procedures
* Limited visibility into complaints nearing deadlines

### Treatment Group (New Workflow)

The enhanced workflow introduced:

* Early complaint triage
* Automated aging-risk flags
* Proactive reminders
* Escalation before Day 40
* Weekly aging review meetings
* Prioritized management of high-risk complaints

---

## Dataset

The dataset contains 12,000 complaint records.

| Group                    |  Cases |
| ------------------------ | -----: |
| Control (Old Workflow)   |  6,000 |
| Treatment (New Workflow) |  6,000 |
| Total                    | 12,000 |

### Dataset Fields

| Column                   | Description                  |
| ------------------------ | ---------------------------- |
| complaint_id             | Unique complaint identifier  |
| ab_group                 | Control or Treatment         |
| workflow_description     | Workflow assigned            |
| region                   | Geographic region            |
| complaint_type           | Complaint category           |
| priority                 | Priority classification      |
| owner_group              | Responsible team             |
| date_entered             | Complaint received date      |
| closed_date              | Complaint closure date       |
| issue_age_days           | Days from receipt to closure |
| late_complaint           | Binary indicator (1=Late)    |
| late_complaint_status    | Late / On-Time               |
| early_triage_completed   | Yes/No                       |
| aging_flag_triggered     | Yes/No                       |
| escalation_before_day_40 | Yes/No                       |

---

## Methodology

### Step 1: Calculate Complaint Age

```text
Issue Age = Closed Date − Date Entered
```

### Step 2: Define Late Complaints

```text
Late Complaint = Issue Age > 45 Days
```

### Step 3: Calculate Late Complaint Rate

```text
Late Complaint Rate =
Late Complaints / Total Complaints
```

### Step 4: Compare Control and Treatment Groups

The primary KPI was the percentage of complaints closed after 45 days.

### Step 5: Perform Statistical Significance Testing

A Two-Proportion Z-Test was used to compare late complaint rates between groups.

#### Null Hypothesis (H0)

```text
Late Rate(Control) = Late Rate(Treatment)
```

#### Alternative Hypothesis (H1)

```text
Late Rate(Control) > Late Rate(Treatment)
```

---

## Results

| Metric      | Control | Treatment |
| ----------- | ------: | --------: |
| Total Cases |   6,000 |     6,000 |
| Late Cases  |   1,800 |     1,530 |
| Late Rate   |   30.0% |     25.5% |

### Relative Reduction

```text
(30.0% - 25.5%) / 30.0%
= 15%
```

### Key Finding

The treatment workflow reduced late complaints by 15% relative to the existing process.

The statistical test confirmed that the reduction was statistically significant, indicating that the improvement was unlikely to have occurred by chance.

---

## Business Impact

If applied to an operation processing 100,000 complaints annually:

| Metric          | Old Workflow |                New Workflow |
| --------------- | -----------: | --------------------------: |
| Late Complaints |       30,000 |                      25,500 |
| Reduction       |            - | 4,500 fewer late complaints |

Potential benefits include:

* Improved regulatory compliance
* Reduced operational backlog
* Improved customer satisfaction
* Earlier risk identification
* Better resource allocation
* Faster complaint resolution

---

## Project Structure

```text
complaint-ab-testing/
│
├── data/
│   └── complaint_ab_test_12000_cases.csv
│
├── scripts/
│   └── complaint_ab_test_analysis.R
│
├── outputs/
│   ├── summary_tables/
│   ├── charts/
│   └── statistical_results/
│
├── README.md
│
└── requirements.txt
```

---

## Technologies Used

* R
* Statistics
* A/B Testing
* Hypothesis Testing
* Data Analysis
* Data Visualization
* Process Improvement Analytics

---

## Future Enhancements

Potential improvements include:

* Logistic Regression Modeling
* Complaint Risk Prediction
* Survival Analysis
* Time-to-Resolution Forecasting
* Power BI Dashboard
* Streamlit Application
* Docker Deployment
* Automated Monitoring Pipeline

---

## Author

**Festus Eriamiatoe, PhD**

Data Scientist | Analytics Professional | Machine Learning Enthusiast

Specializing in healthcare analytics, process optimization, statistical modeling, business intelligence, and AI-driven decision support systems.
