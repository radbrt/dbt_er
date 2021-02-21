WITH virksomheter AS (
    SELECT CAST(organisasjonsnummer AS STRING) AS orgnr,
    navn,
    CAST(overordnetEnhet AS STRING) AS orgnr_foretak,
    antallAnsatte AS antall_ansatte,
    naeringskode1.kode AS nkode1,
    CAST(valid_date AS DATE) AS valid_date
    FROM {{ source('enhetsregisteret', 'wrk_virksomheter') }}
), 
max_date AS (
        SELECT CAST(current_date AS DATE) AS current_date FROM {{ ref('wrk_max_virk_load_date') }}
)
SELECT * FROM virksomheter
WHERE valid_date IN(
    SELECT current_date FROM max_date
)