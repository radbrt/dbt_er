{{ config(
    materialized = "table"
)}}

SELECT MAX(valid_date) AS current_date FROM {{ source('enhetsregisteret', 'wrk_foretak')}}