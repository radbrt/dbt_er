WITH virksomheter AS (
    SELECT 
    orgnr, 
    navn,
    orgnr_foretak,
    nkode1,
    antall_ansatte,
    CAST(valid_date AS timestamp) AS updated_at
    FROM {{ ref('wrk_virksomheter_010') }}
)
SELECT * FROM virksomheter