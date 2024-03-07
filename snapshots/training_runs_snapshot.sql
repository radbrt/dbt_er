{% snapshot training_runs_snapshot %}

{{
    config(
      strategy='timestamp',
      updated_at='timestamp',
      unique_key='uuid',
      target_schema = 'snapshots',
      target_database = 'dbthouse'
    )
}}

select * from {{ ref('walmart_weekly_sales_train') }}

{% endsnapshot %}