{{ config(materialized='view') }}

with base as (

    select
        a.meter_id,
        a.anomaly_status,
        d.meter_type,
        d.district,
        d.status
    from {{ ref('mart_anomalies') }} a
    left join {{ ref('dim_meters') }} d
        on a.meter_id = d.meter_id

),

summary as (

    select
        anomaly_status,
        meter_type,
        district,
        status,
        count(*) as total_anomalies,
        round(100.0 * count(*) / sum(count(*)) over (), 2) as anomaly_percent
    from base
    group by anomaly_status, meter_type, district, status

)

select *
from summary
order by total_anomalies desc
