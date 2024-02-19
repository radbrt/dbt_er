WITH source AS (
  SELECT 
    stillingsnummer,
    to_date(registrert_dato, 'DD.MM.YYYY') AS registrert_dato,
    stillingstittel,
    yrkeskode,
    bedrift_org_nr,
    antall_stillinger,
    ROW_NUMBER() OVER (PARTITION BY stillingsnummer ORDER BY registrert_dato DESC) AS row_number
  FROM {{ source('nav', 'all_jobs') }}
  WHERE bedrift_org_nr IS NOT NULL
  AND foretak_org_nr IS NOT NULL
),
last_ad_unique AS (
  SELECT
    stillingsnummer,
    registrert_dato,
    stillingstittel,
    yrkeskode,
    bedrift_org_nr,
    antall_stillinger
  FROM source
  WHERE row_number = 1
)
SELECt * FROM last_ad_unique