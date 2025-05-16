CREATE OR REPLACE VIEW monthly_registrations AS
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    COUNT(*) AS user_count
FROM users
GROUP BY year, month
ORDER BY year, month;


SELECT * FROM monthly_registrations;

SELECT * FROM monthly_registrations WHERE year = 2023;

SELECT * FROM monthly_registrations 
WHERE year = EXTRACT(YEAR FROM CURRENT_DATE);

SELECT * FROM monthly_registrations 
WHERE (year || '-' || LPAD(month::text, 2, '0'))::date >= (CURRENT_DATE - INTERVAL '6 months')::date;

SELECT 
    year,
    SUM(user_count) AS total_users
FROM monthly_registrations
GROUP BY year
ORDER BY year;