WITH foretak AS (
    SELECT 
    orgnr, 
    navn,
    nkode1,
    antall_ansatte,
    CAST(valid_date AS timestamp) AS updated_at
    FROM {{ ref('wrk_foretak_010') }}
)
SELECT * FROM foretak