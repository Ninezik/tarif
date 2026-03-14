SELECT *
FROM (
    SELECT *,
    row_number() OVER(
        PARTITION BY connote__connote_service,
        location_data_created__custom_field__nopen,
        custom_field__destination_nopen
        ORDER BY connote__created_at desc ,jumlah DESC,nilai DESC
    ) AS urutan
    FROM (
        select
        date_trunc('month',nipos.connote__created_at )connote__created_at ,
            nipos.connote__connote_service,
            nipos.location_data_created__custom_field__nopen,
            nipos.connote__zone_code_to AS custom_field__destination_nopen,
            round(nipos.connote__connote_service_price /
            GREATEST(GREATEST(connote__actual_weight, connote__chargeable_weight),1),0)nilai,
            COUNT(*) AS jumlah
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
        and  nipos.connote__connote_state NOT IN ('CANCEL','PENDING')
        AND nipos.connote__create_from = 'POSINDOOUTGOING'
        and nipos.connote__connote_service !='LNINCOMING'
        AND nipos.connote__created_at > '20240101'
        GROUP BY 1,2,3,4,5
    ) t1
) t2
WHERE urutan = 1
