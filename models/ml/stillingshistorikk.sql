WITH source AS (
  SELECT * FROM {{ source('cases', 'stillingshistorikk') }}
),
formatted AS (
  SELECT 
    Aksjon_Kd::INT AS aksjon_kode,
    Aksjon_Dato::DATE AS aksjon_dato,
    synthId::INT AS syntetisk_id,
    stillingsforhold::TEXT AS stillingsforhold,
    Deltid::FLOAT AS stillingsprosent,
    Loenn::FLOAT AS loenn
  FROM source
)
SELECT * FROM formatted

