-- models/smart_waterflow_project/int_flow_summary.sql

{{ config(materialized='view') }}

with base as (

    select * 
    from {{ ref('stg_meter_readings') }}

),

hourly_metrics as (

    select
        meter_id,
        timestamp_trunc(timestamp, hour) as hour,
        avg(flow_lmin) as avg_flow_lmin,
        avg(pressure_psi) as avg_pressure_psi,
        count(*) as readings_count
    from base
    group by meter_id, hour

),

with_window_calculations as (

    select
        *,
        -- 3-hour rolling average flow
        avg(avg_flow_lmin) over (
            partition by meter_id
            order by hour
            rows between 2 preceding and current row
        ) as rolling_avg_flow_3h,

        -- Flow delta vs previous hour
        avg_flow_lmin - lag(avg_flow_lmin) over (
            partition by meter_id
            order by hour
        ) as flow_change
    from hourly_metrics

)

select * from with_window_calculations
