{{config(materialized='table')}}

WITH source AS (
  SELECT 
  to_varchar(naerk) AS naerk,
  naerk_tekst
  FROM {{ source('landing', 'nkoder') }}
)
SELECT * FROM source


