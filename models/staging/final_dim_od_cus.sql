{{ config(materialized='table') }}

with tb1 as 
(
    select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as number_of_orders
    from {{ ref('stg_order')}}
    group by customer_id
),

final as (
    select
    a.first_name,
    a.last_name,
    b.first_order_date,
    b.most_recent_order_date,
    coalesce(b.number_of_orders,0) as number_of_orders
    from {{ ref('stg_customer')}} as a
    join tb1 as b
    on a.customer_id=b.customer_id
)

select * from final