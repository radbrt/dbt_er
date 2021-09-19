{% snapshot dwh_foretak_scd2 %}

    {{
        config(
          strategy='check',
          unique_key='orgnr',
          check_cols=['navn', 'nkode1', 'antall_ansatte'],
        )
    }}

    select * from {{ ref('wrk_foretak_010')  }}

{% endsnapshot %}
