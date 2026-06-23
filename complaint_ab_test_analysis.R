
# A/B Testing Analysis for Complaint Resolution Workflow
# Dataset: complaint_ab_test_12000_cases.csv

# -----------------------------
# 1. Load data
# -----------------------------
complaints <- read.csv("complaint_ab_test_12000_cases.csv")

# -----------------------------
# 2. Create late complaint flag
# Late complaint = issue_age_days > 45
# -----------------------------
complaints$late_flag <- ifelse(complaints$issue_age_days > 45, 1, 0)

# -----------------------------
# 3. Summarize old vs new workflow
# -----------------------------
summary_table <- aggregate(
  late_flag ~ ab_group,
  data = complaints,
  FUN = function(x) c(
    total_cases = length(x),
    late_cases = sum(x),
    late_rate = mean(x)
  )
)

summary_table <- do.call(data.frame, summary_table)

colnames(summary_table) <- c(
  "workflow_group",
  "total_cases",
  "late_cases",
  "late_rate"
)

summary_table$late_rate_percent <- round(summary_table$late_rate * 100, 2)

print(summary_table)

# -----------------------------
# 4. Calculate relative reduction
# -----------------------------
control_rate <- summary_table$late_rate[
  summary_table$workflow_group == "Control_Old_Workflow"
]

treatment_rate <- summary_table$late_rate[
  summary_table$workflow_group == "Treatment_New_Workflow"
]

absolute_difference <- control_rate - treatment_rate

relative_reduction <- absolute_difference / control_rate

cat("Control late rate:", round(control_rate * 100, 2), "%\n")
cat("Treatment late rate:", round(treatment_rate * 100, 2), "%\n")
cat("Absolute percentage point reduction:", round(absolute_difference * 100, 2), "points\n")
cat("Relative reduction:", round(relative_reduction * 100, 2), "%\n")

# -----------------------------
# 5. Two-proportion significance test
# -----------------------------
late_counts <- c(
  sum(complaints$late_flag[complaints$ab_group == "Control_Old_Workflow"]),
  sum(complaints$late_flag[complaints$ab_group == "Treatment_New_Workflow"])
)

group_totals <- c(
  sum(complaints$ab_group == "Control_Old_Workflow"),
  sum(complaints$ab_group == "Treatment_New_Workflow")
)

# Alternative = greater means:
# Control late rate is greater than treatment late rate
test_result <- prop.test(
  x = late_counts,
  n = group_totals,
  alternative = "greater"
)

print(test_result)

# -----------------------------
# 6. Conclusion
# -----------------------------
if (test_result$p.value < 0.05) {
  cat("Conclusion: The new workflow significantly reduced late complaints.\n")
} else {
  cat("Conclusion: The reduction was not statistically significant.\n")
}

# -----------------------------
# 7. Visualization
# -----------------------------
barplot(
  summary_table$late_rate_percent,
  names.arg = c("Old Workflow", "New Workflow"),
  main = "Late Complaint Rate: Old vs New Workflow",
  ylab = "Late Complaint Rate (%)",
  ylim = c(0, 35)
)

text(
  x = c(0.7, 1.9),
  y = summary_table$late_rate_percent + 1.5,
  labels = paste0(summary_table$late_rate_percent, "%")
)
