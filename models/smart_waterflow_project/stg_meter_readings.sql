-- models/stg_meter_readings.sql
{{ config(materialized='table') }}

with ranked as (
    select
        *,
        row_number() over (
            partition by meter_id, timestamp
            order by updated_at desc
        ) as row_num
    from {{ source('smart_waterflow', 'raw_meter_readings') }}
)

select
    meter_id,
    timestamp,
    flow_lmin,
    pressure_psi,
    latitude,
    longitude,
    updated_at,
    meter_type,
    district,
    status
from ranked
where row_num = 1

