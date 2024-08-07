with source AS (
  SELECT value FROM {{ source('lake', 'people')}}
), cleaned AS (
  SELECT
    raw:address::string AS adr,
    raw:company::string AS company
  FROM source
)
SELECT * FROM cleaned
