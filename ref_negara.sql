select distinct nipos.connote__connote_receiver_address_detail ,
nipos.connote__zone_code_to
from nipos
where nipos.connote__create_from ='POSINDOOUTGOING'
--and nipos.connote__actual_weight >0
--and nipos.connote__connote_service_price >1000
and left(connote__connote_receiver_address_detail,3)=connote__zone_code_to+('-')
--limit 100
