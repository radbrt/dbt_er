WITH source AS (
  SELECT
*
  FROM {{ source('cases', 'nyc_payroll')}}
),
formatted AS (
  SELECT 
    CAST("FISCAL YEAR" AS INT) AS fiscal_year,
    "AGENCY NAME" AS agency_name,
    "LAST NAME" AS last_name,
    "FIRST NAME" AS first_name,
    "MID INIT" AS mid_init,
    TO_DATE("AGENCY START DATE", 'MM/DD/YYYY') AS agency_start_date,
    "WORK LOCATION BOROUGH" AS work_location_borough,
    "TITLE DESCRIPTION" AS title_description,
    "LEAVE STATUS AS OF JUNE 30" AS leave_status_as_of_june_30,
    CAST(SUBSTR("BASE SALARY", 2) AS NUMERIC) AS base_salary,
    "PAY BASIS" AS pay_basis,
    CAST("REGULAR HOURS" AS NUMERIC) AS regular_hours,
    CAST(SUBSTR("REGULAR GROSS PAID", 2) AS NUMERIC) AS regular_gross_paid,
    CAST("OT HOURS" AS NUMERIC) AS ot_hours,
    CAST(SUBSTR("TOTAL OT PAID", 2) AS NUMERIC) AS total_ot_paid,
    CAST(SUBSTR("TOTAL OTHER PAY", 2) AS NUMERIC) AS total_other_pay
    FROM source
)
SELECT * FROM formatted