SELECT 
date(nipos.connote__created_at)connote__created_at,
nipos.connote__connote_service ,
coalesce(nipos.custom_field__destination_nopen ,nipos.connote__connote_receiver_zipcode )||'-'||nipos.connote__zone_code_to custom_field__destination_nopen,
nipos.custom_field__destination_kprk ,
nipos.location_data_created__custom_field__nokprk ,
COUNT(nipos.connote__connote_code)connote__connote_code,
SUM(nipos.connote__connote_service_price + nipos.connote__connote_surcharge_amount) pendapatan
FROM nipos.nipos
WHERE (customer_code IN (
'UKMTLKMPADI02120A',
'TELTSELNTE02100A',
'RBTOZIYAD04571A',
'RBTOKARNUS05612A',
'RBAGGUARDIA02100A',
'PERCGRAMEDIA02100A',
'LOGKIRIMAJA04550A',
'LOGCARGO505600A',
'LOGBOSAMPUH04563A',
'LOGAUTOKIRM05603A',
'KONSSUPERPSR02100A',
'KONSBITESHIP02120A',
'FINBRINGIN02100A',
'DAGZALORA04170A',
'DAGTOKPED02110A',
'DAGTOCO02150A',
'DAGTOCO02100A',
'DAGSHOPEE04120A',
'DAGSETIAP03400A',
'DAGREGARSPR04576A',
'DAGKPAKETID04550A',
'DAGALEEFA03413A',
'BANKBRI02100A'
)
OR customer_code IS null)
and nipos.connote__connote_state not in ('CANCEL','PENDING')
and nipos.connote__connote_service !='LNINCOMING'
and nipos.connote__create_from ='POSINDOOUTGOING'
and nipos.connote__created_at >'20240101'
and nipos.connote__connote_amount >0
group by 1,2,3,4,5
