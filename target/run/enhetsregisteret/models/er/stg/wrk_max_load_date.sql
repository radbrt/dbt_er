

  create or replace table `radjobads`.`enhetsregisteret`.`wrk_max_load_date`
  
  
  OPTIONS()
  as (
    

SELECT MAX(valid_date) AS current_date FROM `radjobads`.`enhetsregisteret`.`wrk_foretak`
  );
    