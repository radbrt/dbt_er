{{config(materialized='view')}}

WITH jobs_jun AS (
    SELECT * FROM {{ source('nav', 'all_jobs') }}
   
)
SELECT * FROM jobs_jun