-- mart_anomalies_with_location.sql
with
    anomalies as (select * from {{ ref("mart_anomalies") }}),

    locations as (

        select meter_id, latitude, longitude from {{ ref("stg_meter_readings") }}

    ),

    joined as (

        select
            a.meter_id,
            a.hour,
            a.anomaly_status,
            a.avg_flow_lmin,
            a.avg_pressure_psi,
            l.latitude,
            l.longitude,
            st_geogpoint(l.longitude, l.latitude) as geo_point
        from anomalies a
        left join locations l on a.meter_id = l.meter_id

    )

select *
from joined
