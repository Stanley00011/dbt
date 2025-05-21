{{ config(materialized='table') }}

with latest_meter_data as (
    select *
    from {{ ref('stg_meter_readings') }}
    qualify row_number() over (partition by meter_id order by updated_at desc) = 1
)

select
    meter_id,
    meter_type,
    district,
    latitude,
    longitude,
    status
from latest_meter_data
