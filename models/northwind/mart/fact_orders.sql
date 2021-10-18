{{ config(materialized='table') }}

with
    customers as (
        select
            customer_sk
          , customer_id
        from {{ ref('dim_customers') }}    
    )
,

    products as (
        select
          product_sk
        , product_id

        from {{ ref('dim_products') }}
    )
,

    employees as (
        select
          employee_sk
        , employee_id

        from {{ ref('dim_employees') }}  
    )
,

    shippers as (
        select
          shipper_sk
        , shipper_id

        from {{ ref('dim_shippers') }}  
    )
,

    o_details as (
        select
           order_id
         , product_sk as product_fk                             
         , unit_price
         , quantity
         , discount

        from {{ ref('stg_order_details') }}
        left join products using(product_id)          
    )

,   orders_with_sk as (
        select
            orders.order_id
          , customers.customer_sk as customer_fk
          , employees.employee_sk as employee_fk        
          , orders.order_date                  
          , orders.ship_region
          , orders.shipped_date
          , orders.ship_country
          , orders.ship_address
          , orders.ship_postal_code
          , orders.ship_city
          , shippers.shipper_id as shipper_fk
          , orders.ship_name
          , orders.freight
          , orders.required_date

        from {{ ref('stg_orders') }} orders

        left join customers using(customer_id)
        left join employees using(employee_id)                
        left join shippers using(shipper_id)                
)

, final as (
    select
        o_details.order_id
      , orders_with_sk.customer_fk 
      , orders_with_sk.employee_fk         
      , orders_with_sk.order_date
      , o_details.product_fk
      , o_details.unit_price
      , o_details.quantity
      , o_details.discount                  
      , orders_with_sk.ship_region
      , orders_with_sk.shipped_date
      , orders_with_sk.ship_country
      , orders_with_sk.ship_address
      , orders_with_sk.ship_postal_code
      , orders_with_sk.ship_city 
      , orders_with_sk.shipper_fk 
      , orders_with_sk.ship_name
      , orders_with_sk.freight
      , orders_with_sk.required_date

      from orders_with_sk
      left join o_details using(order_id)
)

select * from final