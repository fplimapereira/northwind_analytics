with
    source_data as (
        select
            employee_id
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

        from {{ source('erp_northwind_10_2021', 'employees') }}          
    )

select * from source_data