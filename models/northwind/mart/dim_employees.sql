{{ config(materialized='table') }}

with
    staging as (
        select * from {{ ref('stg_employees')}}
    )

  , transformed as (
      select
        row_number() over (order by employee_id) as employee_sk -- auto-incremental surrogate key
      , employee_id
      , first_name
      , last_name
      , title
      , title_of_courtesy
      , hire_date
      , birth_date
      , address
      , city
      , postal_code
      , region
      , country
      , home_phone
      , extension
      , notes
      , reports_to

      from staging  
  )

  select * from transformed