-- models/stg_meter_readings.sql
with
    source as (select * from {{ source("smart_waterflow", "raw_meter_readings") }}),

    cleaned as (

        select
            cast(meter_id as int64) as meter_id,
            timestamp,
            cast(flow_rate_lmin as float64) as flow_rate_lmin,
            cast(pressure_psi as float64) as pressure_psi,
            cast(temperature_c as float64) as temperature_c,
            lower(status) as status,
            cast(latitude as float64) as latitude,
            cast(longitude as float64) as longitude

        from source

    )

select *
from cleaned
