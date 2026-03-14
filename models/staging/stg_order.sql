{{ config(materialized='table') }}

with tb1 as (
    select 
    id as order_id,
    user_id	as customer_id,
    order_date,
    status
    from {{ source('datafeed_shared_schema','RAW_ORDERS_DATA')}}
)

select * from tb1