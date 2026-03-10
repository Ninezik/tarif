select location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service,
nilai,
jumlah,
rank_service
FROM
(select*,
row_number() OVER(partition by location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service
order by t1.connote__created_at desc,nilai desc) rank_service
FROM
(
SELECT
location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service,
date_trunc('month',connote__created_at)connote__created_at,
round(
nipos.connote__connote_service_price/GREATEST(connote__chargeable_weight, 1)) nilai,
COUNT(*)jumlah
FROM nipos.nipos
WHERE location_data_created__custom_field__nopen is not NULL
and custom_field__destination_nopen is not null
and nipos.connote__connote_service !='LNINCOMING'
and nipos.connote__chargeable_weight >=0
and nipos.connote__connote_amount >0
and nipos.connote__connote_state not in ('CANCEL','PENDING')
and nipos.connote__connote_service !='PJB'
and nipos.connote__created_at >'20240101'
GROUP BY 1,2,3,4,5
)t1
)t2
where rank_service=1
order by 1,2,3
