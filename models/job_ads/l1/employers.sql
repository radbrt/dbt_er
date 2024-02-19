WITH source AS (
  SELECT 
    foretak_org_nr,
    foretak_navn,
    arbeidssted_kommunenummer AS foretak_kommunenummer,
    arbeidssted_kommune AS foretak_kommune,
    arbeidssted_fylkesnummer AS foretak_fylkesnummer,
    arbeidssted_fylke AS foretak_fylke,
    foretak_sektor_gruppe,
    ROW_NUMBER() OVER (PARTITION BY foretak_org_nr ORDER BY registrert_dato DESC) AS row_number
  FROM {{ source('nav', 'all_jobs') }}
  WHERE foretak_org_nr IS NOT NULL
),
last_foretak_unique AS (
  SELECT
    foretak_org_nr,
    foretak_navn,
    foretak_kommunenummer,
    foretak_kommune,
    foretak_sektor_gruppe
  FROM source
  WHERE row_number = 1
)
SELECT * FROM last_foretak_unique
