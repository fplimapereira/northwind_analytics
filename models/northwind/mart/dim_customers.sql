{{ config(materialized='table') }}

with
    staging as (
        select * from {{ ref('stg_customers')}}
    )

  , transformed as (
      select
        row_number() over (order by customer_id) as customer_sk -- auto-incremental surrogate key
      , customer_id
      , country
      , city
      , fax
      , postal_code
      , address
      , region
      , contact_name
      , contact_title
      , phone
      , company_name

      from staging  
  )

  select * from transformed