{{ config(materialized='table') }}

with
    suppliers as (
        select
            supplier_id
          , company_name
          , country

        from {{ ref('stg_suppliers') }}
    )
,
    categories as (
        select
            category_id
          , category_name
          , description

        from {{ ref('stg_categories') }}    
    )
,
    transformed as (
        select
            row_number() over (order by product_id) as product_sk -- auto-incremental surrogate key
          , products.product_id
          , products.product_name 
          , categories.category_id
          , categories.category_name
          , categories.description as ctgy_description
          , suppliers.supplier_id
          , suppliers.company_name
          , suppliers.country
          , products.quantity_per_unit
          , products.unit_price
          , products.units_in_stock
          , products.units_on_order
          , products.reorder_level
          , products.discontinued 

        from {{ ref('stg_products') }} products
        left join suppliers using(supplier_id)
        left join categories using(category_id)
    )

    select * from transformed

