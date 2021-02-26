{{ config(
    materialized = "table"
)}}

SELECT MAX(valid_date) AS max_valid_date FROM {{ source('enhetsregisteret', 'wrk_virksomheter')}}