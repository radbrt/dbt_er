WITH foretak AS (
    SELECT CAST(organisasjonsnummer AS STRING) AS orgnr,
    antall_ansatte,
    naeringskode1.kode AS nkode1
    FROM {{ ref('wrk_foretak') }}
)
SELECT * FROM foretak