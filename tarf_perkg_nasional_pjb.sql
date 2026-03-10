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
order by t1.ceiling_berat,t1.connote__created_at DESC) rank_service
FROM
(SELECT
location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service,
date_trunc('month',connote__created_at)connote__created_at,
(ceiling(nipos.connote__chargeable_weight /10)*10) ceiling_berat,
round(
nipos.connote__connote_service_price/
(ceiling(nipos.connote__chargeable_weight /10)*10),0) nilai,
COUNT(*)jumlah
FROM nipos.nipos
WHERE location_data_created__custom_field__nopen is not NULL
and custom_field__destination_nopen is not null
and nipos.connote__connote_service !='LNINCOMING'
and nipos.connote__chargeable_weight >0
and nipos.connote__connote_amount >0
and nipos.connote__connote_state not in ('CANCEL','PENDING')
and nipos.connote__connote_service ='PJB'
and nipos.connote__created_at >'20240101'
GROUP BY 1,2,3,4,5,6
--limit 10
)t1
)t2
where rank_service=1
