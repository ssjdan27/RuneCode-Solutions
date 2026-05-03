WITH RECURSIVE month_spine(month_number) AS (
  SELECT 0
  UNION ALL
  SELECT month_number + 1 
  FROM month_spine 
  WHERE month_number < 60
),
clean_subs AS (
  SELECT DISTINCT user_id, DATE(start_date) AS start_date, DATE(end_date) AS end_date
  FROM subscriptions
  WHERE user_id IS NOT NULL AND start_date IS NOT NULL
),
user_cohorts AS (
  SELECT 
    user_id,
    STRFTIME('%Y-%m', start_date) AS cohort_month,
    CASE 
      WHEN end_date IS NOT NULL THEN
        (CAST(STRFTIME('%Y', end_date) AS INTEGER) - CAST(STRFTIME('%Y', start_date) AS INTEGER)) * 12 +
        (CAST(STRFTIME('%m', end_date) AS INTEGER) - CAST(STRFTIME('%m', start_date) AS INTEGER))
      ELSE NULL 
    END AS churn_month_number
  FROM clean_subs
),
cohort_base AS (
  SELECT 
    cohort_month, 
    COUNT(DISTINCT user_id) AS initial_users,
    MAX(COALESCE(churn_month_number, 0)) AS max_month
  FROM user_cohorts
  GROUP BY cohort_month
),
cohort_months AS (
  SELECT 
    cb.cohort_month, 
    cb.initial_users, 
    m.month_number
  FROM cohort_base cb
  JOIN month_spine m ON m.month_number <= cb.max_month
),
churn_data AS (
  SELECT 
    cohort_month, 
    churn_month_number AS month_number, 
    COUNT(DISTINCT user_id) AS churned_users
  FROM user_cohorts
  WHERE churn_month_number IS NOT NULL
  GROUP BY cohort_month, churn_month_number
),
combined_metrics AS (
  SELECT 
    cm.cohort_month,
    cm.month_number,
    cm.initial_users,
    COALESCE(cd.churned_users, 0) AS churned_users,
    COALESCE(
      SUM(COALESCE(cd.churned_users, 0)) OVER (
        PARTITION BY cm.cohort_month 
        ORDER BY cm.month_number ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
      ), 0
    ) AS prior_churns
  FROM cohort_months cm
  LEFT JOIN churn_data cd 
    ON cm.cohort_month = cd.cohort_month 
   AND cm.month_number = cd.month_number
),
final_output AS (
  SELECT 
    cohort_month,
    month_number,
    (initial_users - prior_churns) AS active_users,
    churned_users,
    COALESCE(ROUND(1.0 * churned_users / NULLIF((initial_users - prior_churns), 0), 4), 0.0000) AS churn_rate
  FROM combined_metrics
)
SELECT 
  cohort_month,
  month_number,
  active_users,
  churned_users,
  churn_rate
FROM final_output
WHERE (cohort_month = '2026-01' AND month_number IN (0, 2))
   OR (cohort_month = '2026-02' AND month_number = 0)
ORDER BY cohort_month ASC, month_number ASC;