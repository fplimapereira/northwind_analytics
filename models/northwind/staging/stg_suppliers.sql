with
    source_data as (
        select
            supplier_id
          , company_name
          , contact_name
          , contact_title
          , address
          , city
          , region
          , country
          , postal_code
          , phone
          , fax
          , homepage                   

        from {{ source('erp_northwind_10_2021', 'suppliers') }}          
    )

select * from source_data