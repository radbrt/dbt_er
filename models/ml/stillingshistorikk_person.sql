WITH stillingshistorikk AS (
  SELECT * FROM {{ ref('stillingshistorikk') }}
),
preprocessed AS (
  SELECT
    syntetisk_id,
    MIN(aksjon_dato)  AS first_action_date,
    MAX(aksjon_dato)  AS last_action_date,
    AVG(stillingsprosent) AS average_stillingsprosent,
    AVG(loenn) AS average_loenn,
    COUNT(DISTINCT stillingsforhold) AS num_stillingsforhold,
    MAX_BY(aksjon_kode, aksjon_dato) AS siste_hendelse
  FROM stillingshistorikk
  GROUP BY syntetisk_id
),
joined AS (
  SELECT
    persondata.syntetisk_id,
    person_foedt_aar,
    sivil_status_kd,
    kjoenn_kd,
    adresse_utland_flg,
    alder_aar_mnd_eksakte,
    pensjonsordning_kd_siste,
    siste_hendelse,
    CASE WHEN siste_hendelse = 31 THEN 1 ELSE 0 END AS sluttet_stilling,
    LAND,
    gruppe_foedt_kd,
    first_action_date,
    last_action_date,
    average_stillingsprosent,
    average_loenn,
    num_stillingsforhold
  FROM {{ref('persondata')}}
  INNER JOIN preprocessed ON persondata.syntetisk_id = preprocessed.syntetisk_id
)
SELECT * FROM joined

