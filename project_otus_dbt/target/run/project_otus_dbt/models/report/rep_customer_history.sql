
  create view "postgres"."public"."rep_customer_history__dbt_tmp" as (
    



select hc.customer_key::integer
    ,hc.customer_pk
    ,sc.first_name
    ,sc.last_name
    ,sc.email
    ,scc.country
    ,scc.age
    ,'2022-02-03 14:30:00'::timestamp(0) as given_dttm
from "postgres"."public"."hub_customer" as hc 
left join (
    select sc.customer_pk
        ,sc.first_name
        ,sc.last_name
        ,sc.email
        ,sc.effective_from 
        ,coalesce(lead(sc.effective_from) over(partition by sc.customer_pk order by sc.effective_from)-interval '1 second'
            ,'5999-12-31 00:00:00'::timestamp) as effective_to
    from "postgres"."public"."sat_customer_details" as sc 
    )   as sc
on hc.customer_pk=sc.customer_pk
    and '2022-02-03 14:30:00'::timestamp between sc.effective_from and sc.effective_to
left join (    
    select scc.customer_pk
        ,scc.country
        ,scc.age
        ,scc.effective_from 
        ,coalesce(lead(scc.effective_from) over(partition by scc.customer_pk order by scc.effective_from)-interval '1 second'
            ,'5999-12-31 00:00:00'::timestamp) as effective_to
    from  "postgres"."public"."sat_customer_crm_details" as scc
    ) as scc
on hc.customer_pk=scc.customer_pk
    and '2022-02-03 14:30:00'::timestamp between scc.effective_from and scc.effective_to
  );
