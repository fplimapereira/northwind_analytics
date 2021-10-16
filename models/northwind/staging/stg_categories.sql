with
    source_data as (
        select
            category_id
          , category_name
          , description                       

        from {{ source('erp_northwind_10_2021', 'categories') }}          
    )

select * from source_data