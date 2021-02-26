{% snapshot foretak %}

{{
    config(
        target_database='radjobads',
        target_schema='enhetsregisteret',
        unique_key='orgnr',
        strategy='eventtime',
        updated_at='updated_at',
        check_cols = ['navn', 'nkode1', 'antall_ansatte'],
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('wrk_foretak_020') }}

{% endsnapshot %}