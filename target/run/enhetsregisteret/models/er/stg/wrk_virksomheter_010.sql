

  create or replace view `radjobads`.`enhetsregisteret`.`wrk_virksomheter_010`
  OPTIONS()
  as WITH virksomheter AS (
    SELECT CAST(organisasjonsnummer AS STRING) AS orgnr,
    navn,
    antallAnsatte AS antall_ansatte,
    naeringskode1.kode AS nkode1,
    CAST(valid_date AS DATE) AS valid_date
    FROM `radjobads`.`enhetsregisteret`.`wrk_virksomheter`
), 
max_date AS (
        SELECT CAST(current_date AS DATE) AS current_date FROM `radjobads`.`enhetsregisteret`.`wrk_max_virk_load_date`
)
SELECT * FROM virksomheter
WHERE valid_date IN(
    SELECT current_date FROM max_date
);

