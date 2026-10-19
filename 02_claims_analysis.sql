-- Core Healthcare Claims Analysis

-- Total claims
SELECT COUNT(*) AS total_claims FROM Claims;

-- Claims by status
SELECT claim_status, COUNT(*) AS claim_count
FROM Claims GROUP BY claim_status ORDER BY claim_count DESC;

-- Financial summary
SELECT SUM(billed_amount) AS total_billed, SUM(allowed_amount) AS total_allowed,
       SUM(paid_amount) AS total_paid, SUM(patient_responsibility) AS total_patient_responsibility,
       SUM(adjustment_amount) AS total_adjustment
FROM Claims;

-- Denial rate
SELECT CAST(100.0 * SUM(CASE WHEN claim_status='Denied' THEN 1 ELSE 0 END) /
       NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS denial_rate_pct
FROM Claims;

-- Monthly trend
SELECT YEAR(service_date) service_year, MONTH(service_date) service_month,
       COUNT(*) claim_count, SUM(billed_amount) billed_amount, SUM(paid_amount) paid_amount
FROM Claims GROUP BY YEAR(service_date), MONTH(service_date)
ORDER BY service_year, service_month;

-- Payer performance
SELECT p.payer_name, COUNT(c.claim_id) total_claims, SUM(c.billed_amount) billed_amount,
       SUM(c.paid_amount) paid_amount,
       SUM(CASE WHEN c.claim_status='Denied' THEN 1 ELSE 0 END) denied_claims,
       CAST(100.0*SUM(CASE WHEN c.claim_status='Denied' THEN 1 ELSE 0 END) /
       NULLIF(COUNT(c.claim_id),0) AS DECIMAL(10,2)) denial_rate_pct
FROM Claims c JOIN Payers p ON c.payer_id=p.payer_id
GROUP BY p.payer_name ORDER BY total_claims DESC;

-- Top denial reasons
SELECT denial_reason, COUNT(*) denied_claims, SUM(billed_amount) denied_billed_amount
FROM Claims WHERE claim_status='Denied'
GROUP BY denial_reason ORDER BY denied_claims DESC;

-- Service category analysis
SELECT pr.service_category, COUNT(c.claim_id) claim_count,
       SUM(c.billed_amount) billed_amount, SUM(c.allowed_amount) allowed_amount,
       SUM(c.paid_amount) paid_amount
FROM Claims c JOIN Procedures pr ON c.cpt_code=pr.cpt_code
GROUP BY pr.service_category ORDER BY paid_amount DESC;
