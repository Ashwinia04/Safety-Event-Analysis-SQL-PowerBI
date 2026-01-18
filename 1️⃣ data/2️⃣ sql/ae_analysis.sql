
-- 1. Get latest adverse event per patient
SELECT *
FROM (
    SELECT
        patient_id,
        event_term,
        severity,
        report_date,
        ROW_NUMBER() OVER (
            PARTITION BY patient_id
            ORDER BY report_date DESC
        ) AS rn
    FROM adverse_events
) t
WHERE rn = 1;

-- 2. Count number of patients by severity
SELECT
    severity,
    COUNT(DISTINCT patient_id) AS patient_count
FROM adverse_events
GROUP BY severity;
