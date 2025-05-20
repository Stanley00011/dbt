-- models/smart_waterflow_project/mart_anomalies.sql

with flow_data as (

    select *
    from {{ ref('int_flow_summary') }}

),

flagged as (

    select
        meter_id,
        hour,
        avg_flow_lmin,
        avg_pressure_psi,
        case 
            when avg_flow_lmin = 0 and avg_pressure_psi = 0 then 'offline'
            when avg_pressure_psi < 30 and avg_flow_lmin > 20 then 'leak'
            when avg_pressure_psi > 100 or avg_flow_lmin > 100 then 'spike'
            else 'normal'
        end as anomaly_status
    from flow_data

)

select * from flagged
