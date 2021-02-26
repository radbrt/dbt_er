WITH foretak AS (
    SELECT CAST(organisasjonsnummer AS STRING) AS orgnr,
    navn,
    antallAnsatte AS antall_ansatte,
    naeringskode1.kode AS nkode1,
    CAST(valid_date AS DATE) AS valid_date
    FROM {{ source('enhetsregisteret', 'wrk_foretak') }}
), 
max_date AS (
        SELECT CAST(max_valid_date AS DATE) AS max_valid_date FROM {{ ref('wrk_max_load_date') }}
)
SELECT * FROM foretak
WHERE valid_date IN(
    SELECT max_valid_date FROM max_date
)