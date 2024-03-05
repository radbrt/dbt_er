with source AS (
  SELECT * FROM {{ source('ssb', 'nkoder') }}
)
SELECT * FROM source