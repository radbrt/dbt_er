WITH source AS (
  SELECT * FROM {{ ref('wrk_foretak_010') }}
  WHERE substr(nace_1, 1, 1)='1'
)
SELECT * FROM source