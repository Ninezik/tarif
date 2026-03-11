SELECT
t1.location_data_created__custom_field__nopen,
t1.custom_field__destination_nopen,
t1.connote__connote_service,
t1.nilai,
t1.jumlah,
t1.rank_service
FROM
(
SELECT
connote_month,
location_data_created__custom_field__nopen,
custom_field__destination_nopen,
connote__connote_service,
nilai,
jumlah,

ROW_NUMBER() OVER (
    PARTITION BY
        location_data_created__custom_field__nopen,
        custom_field__destination_nopen,
        connote__connote_service
    ORDER BY
        connote_month DESC,
        jumlah DESC,
        nilai DESC
) AS rank_service

FROM
(
SELECT
date_trunc('month', nipos.connote__created_at) AS connote_month,

nipos.location_data_created__custom_field__nopen,

coalesce(nipos.custom_field__destination_nopen ,nipos.connote__connote_receiver_zipcode )||'-'||nipos.connote__zone_code_to AS custom_field__destination_nopen,

nipos.connote__connote_service,

CASE
    WHEN ROUND(nipos.connote__connote_service_price / nipos.connote__actual_weight,0) < 100000
    THEN ROUND(nipos.connote__connote_service_price / nipos.connote__chargeable_weight,0)
    ELSE ROUND(nipos.connote__connote_service_price / nipos.connote__actual_weight,0)
END AS nilai,

COUNT(*) AS jumlah

FROM nipos.nipos

WHERE nipos.connote__connote_state NOT IN ('CANCEL','PENDING')
AND nipos.location_data_created__custom_field__nopen IS NOT NULL
--AND nipos.connote__connote_receiver_zipcode IS NOT NULL
AND nipos.connote__create_from = 'POSINDOOUTGOING'
AND nipos.connote__actual_weight > 0
GROUP BY
1,2,3,4,5
) base
) t1
WHERE rank_service = 1
order by 2
