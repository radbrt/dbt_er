WITH source AS (
  SELECT
  bedrift_org_nr,
  foretak_org_nr,
  bedrift_navn,
  ROW_NUMBER() OVER (PARTITION BY bedrift_org_nr ORDER BY registrert_dato DESC) AS row_number
  FROM {{ source('nav', 'all_jobs') }}
  WHERE bedrift_org_nr IS NOT NULL
  AND foretak_org_nr IS NOT NULL
),
last_foretak_unique AS (
  SELECT
  bedrift_org_nr,
  foretak_org_nr,
  bedrift_navn
  FROM source
  WHERE row_number = 1
)
SELECT * FROM last_foretak_unique
