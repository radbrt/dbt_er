WITH source AS (
  SELECT * FROM {{ source('cases', 'persondata') }}
),
formatted AS (
  SELECT
    CAST(person_foedt_aar AS INT) AS person_foedt_aar,
    sivil_status_kd AS sivil_status_kd,
    kjoenn_kd AS kjoenn_kd,
    CAST(CASE WHEN adresse_utland_flg = 'J' THEN 1 ELSE 0 END AS BOOLEAN) AS adresse_utland_flg,
    CAST(alder_aar_mnd_eksakte AS NUMERIC) AS alder_aar_mnd_eksakte,
    pensjonsordning_kd_siste AS pensjonsordning_kd_siste,
    LAND AS LAND,
    gruppe_foedt_kd AS gruppe_foedt_kd,
    synthId AS syntetisk_id
  FROM source
)
SELECT * FROM formatted