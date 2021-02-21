{% snapshot virksomheter %}

{{
    config(
        target_database='radjobads',
        target_schema='enhetsregisteret',
        unique_key='orgnr',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('wrk_virksomheter_020') }}

{% endsnapshot %}