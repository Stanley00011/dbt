-- models/smart_waterflow_project/mart_anomalies.sql
{{ config(materialized="view") }}

with
    flow_data as (select * from {{ ref("int_flow_summary") }}),

    flagged as (

        select
            meter_id,
            hour,
            avg_flow_lmin,
            avg_pressure_psi,
            case
                when avg_flow_lmin <= 0 and avg_pressure_psi <= 40
                then 'offline'
                when avg_pressure_psi < 50 and avg_flow_lmin > 25
                then 'leak'
                when avg_pressure_psi > 80 or avg_flow_lmin > 40
                then 'spike'
                else 'normal'
            end as anomaly_status
        from flow_data

    ),

    locations as (select meter_id, latitude, longitude from {{ ref("dim_meters") }})

select
    a.meter_id,
    a.hour,
    a.anomaly_status,
    a.avg_flow_lmin,
    a.avg_pressure_psi,
    l.latitude,
    l.longitude,
    st_geogpoint(l.longitude, l.latitude) as geo_point
from flagged a
left join locations l on a.meter_id = l.meter_id
