with
    source_data as (
        select
            shipper_id
          , company_name
          , phone                                      

        from {{ source('erp_northwind_10_2021', 'shippers') }}          
    )

select * from source_data