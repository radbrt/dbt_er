WITH source AS (
  SELECT * FROM {{ source('cases', 'walmart_sales')}}
),
formatted AS (
  SELECT 
    CAST(store AS NUMERIC) AS store,
    TO_DATE(date, 'DD-MM-YYYY') AS sales_week_start,
    CAST(weekly_sales AS NUMERIC) AS weekly_sales,
    CAST(holiday_flag AS NUMERIC) AS holiday_flag,
    CAST(temperature AS NUMERIC) AS temperature,
    CAST(fuel_price AS NUMERIC) AS fuel_price,
    CAST(cpi AS NUMERIC) AS cpi,
    CAST(unemployment AS NUMERIC) AS unemployment
    FROM source
)
SELECT * FROM formatted