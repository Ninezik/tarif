SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service
ORDER BY jumlah DESC, nilai DESC
) AS rank_service
FROM (
SELECT
location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service,
ROUND(
connote__connote_service_price / GREATEST(connote__chargeable_weight, 1),
0
) AS nilai,
COUNT(*) AS jumlah
FROM nipos.nipos
WHERE location_data_created__custom_field__nopen is not null
and custom_field__destination_nopen is not null
--AND custom_field__jenis_barang = 'Paket'
--          AND connote__connote_service IN ('PJB','PJE')
and nipos.connote__connote_service !='LN INCOMING'
--AND connote__create_from != 'POSINDOOUTGOING'
and nipos.connote__chargeable_weight >0
and nipos.connote__connote_amount >0
and nipos.connote__connote_state not in ('CANCEL','PENDING')
GROUP BY 1,2,3,4
) t
) x
WHERE rank_service = 1
