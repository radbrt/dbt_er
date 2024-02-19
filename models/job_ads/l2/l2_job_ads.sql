WITH source AS (
  SELECT
  stillingsnummer,
  to_date(registrert_dato, 'DD.MM.YYYY') AS registrert_dato,
  stillingstittel,
  yrkeskode,
  arbeidssted_kommune,
  arbeidssted_kommunenummer,
  arbeidssted_fylke,
  arbeidssted_fylkesnummer,
  arbeidssted_land,
  bedrift_navn,
  bedrift_org_nr,
  foretak_org_nr,
  foretak_navn,
  antall_stillinger,
  foretak_sektor_gruppe,
  ROW_NUMBER() OVER (PARTITION BY stillingsnummer ORDER BY registrert_dato DESC) AS row_number
  from {{ source('nav', 'all_jobs') }}
  ),
  last_ad_unique AS (
  SELECT
  stillingsnummer,
  registrert_dato,
  stillingstittel,
  yrkeskode,
  arbeidssted_kommune AS foretak_kommune,
  arbeidssted_kommunenummer AS foretak_kommunenummer,
  arbeidssted_fylkesnummer AS foretak_fylkesnummer,
  arbeidssted_fylke AS foretak_fylke,
  bedrift_navn,
  bedrift_org_nr,
  foretak_org_nr,
  foretak_navn,
  antall_stillinger,
  foretak_sektor_gruppe
  FROM source
  WHERE row_number = 1
  )
SELECT * FROM last_ad_unique