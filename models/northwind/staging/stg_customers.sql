with
    source_data as (
        select
            customer_id
          , contact_name
          , contact_title
          , company_name
          , phone
          , fax
          , address
          , city
          , region
          , postal_code
          , country

        from {{ source('erp_northwind_10_2021', 'customers') }}  
    )

select * from source_data
