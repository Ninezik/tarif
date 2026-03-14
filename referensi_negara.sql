SELECT
nipos.connote__zone_code_to NOPEND_DIRIAN,
'POSINDOOUTGOING' REGIONAL,
'POSINDOOUTGOING' KCU,
'POSINDOOUTGOING' KC,
nipos.connote__zone_code_to KDNOPEN,
nipos.connote__zone_code_to KDKANTOR,
'POSINDOOUTGOING' jenis,
nipos.connote__connote_receiver_address_detail KETNOPEN
FROM nipos.nipos
WHERE 
nipos.connote__create_from ='POSINDOOUTGOING'
and nipos.connote__created_at >'20240101'
AND left(nipos.connote__connote_receiver_address_detail,3)=nipos.connote__zone_code_to +'-'
