WITH foretak AS (
    SELECT CAST(organisasjonsnummer AS STRING) AS orgnr,
    navn,
    antallAnsatte AS antall_ansatte,
    naeringskode1.kode AS nkode1,
    CAST(valid_date AS DATE) AS valid_date
    FROM `radjobads`.`enhetsregisteret`.`wrk_foretak`
), 
max_date AS (
        SELECT CAST(current_date AS DATE) AS current_date FROM `radjobads`.`enhetsregisteret`.`wrk_max_load_date`
)
SELECT * FROM foretak
WHERE valid_date IN(
    SELECT current_date FROM max_date
)