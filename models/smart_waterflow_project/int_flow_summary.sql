-- models/smart_waterflow_project/int_flow_summary.sql

with base as (

    select * 
    from {{ ref('stg_meter_readings') }}

),

hourly_metrics as (

    select
        meter_id,
        timestamp_trunc(timestamp, hour) as hour,
        avg(flow_rate_lmin) as avg_flow_lmin,
        avg(pressure_psi) as avg_pressure_psi,
        count(*) as readings_count
    from base
    group by meter_id, hour

)

select * from hourly_metrics
