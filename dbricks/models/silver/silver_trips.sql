{{
    config(
        materialized='incremental',
        incremental_strategy = 'insert_overwrite',
        tags = ['daily_trips']
    )
}}

WITH base as (
    SELECT yellow.*
          ,SHA2(CONCAT(VendorID,tpep_pickup_datetime,tpep_dropoff_datetime), 256)            as trip_id
          ,(unix_timestamp(tpep_dropoff_datetime)-unix_timestamp(tpep_pickup_datetime))/(60) as trip_duration_min
          ,trip_distance * 1.6                                                               as trip_distance_km
    FROM {{ ref('stg_trips') }} as yellow
)

SELECT *
FROM base
