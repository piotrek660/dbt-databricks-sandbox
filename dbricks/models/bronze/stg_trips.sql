{{
    config(
        materialized='table',
        tags = ['stg']
    )
}}


SELECT
    vendorid,
    DATE(tpep_pickup_datetime) as pickup_date,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    ratecodeid,
    store_and_fwd_flag,
    pulocationid,
    dolocationid,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    current_timestamp() as load_date
FROM {{ source('pkostuch_sample', 'yellow_taxi') }}
