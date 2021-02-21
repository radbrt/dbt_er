
      merge into `radjobads`.`enhetsregisteret`.`foretak` as DBT_INTERNAL_DEST
    using `radjobads`.`enhetsregisteret`.`foretak__dbt_tmp` as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     and DBT_INTERNAL_DEST.dbt_valid_to is null
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'update'
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert (`orgnr`, `navn`, `nkode1`, `antall_ansatte`, `updated_at`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)
        values (`orgnr`, `navn`, `nkode1`, `antall_ansatte`, `updated_at`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)
    ;

  