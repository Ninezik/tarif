select
t1.location_data_created__custom_field__nopen,
t1.custom_field__destination_nopen,
t1.connote__connote_service,
t1.hasil,
t1.jumlah,
t1.rank_service
from
(SELECT 
    date_trunc('month', nipos.connote__created_at) AS connote_month,
    nipos.location_data_created__custom_field__nopen,
    nipos.custom_field__destination_nopen,
    nipos.connote__connote_service,
    round(nipos.connote__connote_service_price /
        (ceiling(connote__chargeable_weight/10)*10),0) AS hasil,
    COUNT(*) AS jumlah,
    ROW_NUMBER() OVER (
        PARTITION BY 
            nipos.location_data_created__custom_field__nopen,
            nipos.custom_field__destination_nopen,
            nipos.connote__connote_service
        ORDER BY date_trunc('month', nipos.connote__created_at) desc ,COUNT(*) desc,hasil DESC
    ) AS rank_service
FROM nipos.nipos
WHERE nipos.connote__connote_state NOT IN ('CANCEL','PENDING')
and nipos.location_data_created__custom_field__nopen is not null
and nipos.custom_field__destination_nopen  is not NULL
AND nipos.connote__connote_service = 'PJB'
and nipos.connote__connote_service_price >1000
and nipos.connote__chargeable_weight >0
GROUP BY 1,2,3,4,5
)t1
where t1.rank_service=1
