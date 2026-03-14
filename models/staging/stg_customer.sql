{{ config(materialized='table') }}

with tb1 as (
    select
        id as customer_id,
        first_name,
        last_name
    from {{ source('datafeed_shared_schema', 'RAW_CUSTOMERS_DATA') }}
)

select * from tb1