

  create or replace view `radjobads`.`enhetsregisteret`.`wrk_virksomheter_020`
  OPTIONS()
  as WITH virksomheter AS (
    SELECT 
    orgnr, 
    navn,
    nkode1,
    antall_ansatte,
    CAST(valid_date AS timestamp) AS updated_at
    FROM `radjobads`.`enhetsregisteret`.`wrk_virksomheter_010`
)
SELECT * FROM virksomheter;

