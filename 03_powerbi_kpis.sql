-- KPI query for Power BI
SELECT COUNT(*) total_claims,
       SUM(CASE WHEN claim_status='Paid' THEN 1 ELSE 0 END) paid_claims,
       SUM(CASE WHEN claim_status='Denied' THEN 1 ELSE 0 END) denied_claims,
       SUM(CASE WHEN claim_status='Pending' THEN 1 ELSE 0 END) pending_claims,
       SUM(billed_amount) total_billed, SUM(allowed_amount) total_allowed,
       SUM(paid_amount) total_paid, SUM(patient_responsibility) total_patient_responsibility,
       SUM(adjustment_amount) total_adjustment,
       CAST(100.0*SUM(CASE WHEN claim_status='Denied' THEN 1 ELSE 0 END) /
       NULLIF(COUNT(*),0) AS DECIMAL(10,2)) denial_rate_pct,
       CAST(100.0*SUM(paid_amount)/NULLIF(SUM(allowed_amount),0) AS DECIMAL(10,2)) collection_rate_pct
FROM Claims;
