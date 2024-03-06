{{
  config(
    materialized='table',
    alias='foretak'
  )
}}

WITH source as (
  SELECT * FROM {{ source('brreg', 'foretak') }}
), 
latest as (
  SELECT * FROM source WHERE filnavn IN (
    SELECT MAX(filnavn) FROM source
  )
)
SELECT * FROM latest

