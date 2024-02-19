{{config(materialized='view')}}

WITH foretak AS (
    SELECT 
    CAST(organisasjonsnummer AS STRING) AS orgnr,
    navn,
    antallAnsatte AS antall_ansatte,
    naeringskode1_kode AS nace_1
    FROM {{ source('landing', 'foretak_siste') }}
    WHERE nace_1 IN (
        SELECT naerk FROM {{ ref('wrk_nace') }}
        )
)
SELECT * FROM foretak
