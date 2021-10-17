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
         , unit_price
         , quantity
         , discount

        from {{ ref('stg_order_details') }}          
    )

,   orders_with_sk as (
        select
            orders.order_id
          , customers.customer_id
          , employees.employee_id          
          , orders.order_date
          , products.product_id          
          , o_details.unit_price
          , o_details.quantity
          , o_details.discount
          , orders.ship_region
          , orders.shipped_date
          , orders.ship_country
          , orders.ship_address
          , orders.ship_postal_code
          , orders.ship_city as cidade
          , shippers.shipper_id
          , orders.ship_name
          , orders.freight
          , orders.required_date

        from {{ ref('stg_orders') }} orders

        left join customers using(customer_id)
        left join employees using(employee_id)
        left join o_details using(order_id)        
        left join shippers using(shipper_id)
        left join products using(product_id)          
)

select * from orders_with_sk