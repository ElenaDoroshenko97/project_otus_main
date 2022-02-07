with pit_cust as(
    select hc.customer_pk
        ,sc.first_name
        ,sc.last_name
        ,sc.email
        ,sc.effective_from
        ,coalesce(lead(sc.effective_from) over(partition by sc.customer_pk order by sc.effective_from)-interval '1 second'
            ,'5999-12-31 00:00:00'::timestamp) as effective_to
from "postgres"."dbt"."hub_customer" as hc 
    left join "postgres"."dbt"."sat_customer_details" as sc 
on hc.customer_pk=sc.customer_pk
)

select customer_pk
    ,first_name
    ,last_name
    ,email
    ,effective_from
    ,effective_to
from pit_cust