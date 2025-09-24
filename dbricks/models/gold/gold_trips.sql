{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key= ['VendorID','pickup_date', 'DOLocationID', 'PULocationID', 'payment_type'],
        tags = ['fact']
    )
}}


SELECT
       VendorID
      ,pickup_date
      ,trips.DOLocationID
      ,trips.PULocationID
      ,payment_type

      -- dutation
      ,sum(trip_duration_min) trip_duration_sum
      ,max(trip_duration_min) trip_duration_max
      ,avg(trip_duration_min) trip_duration_avg
      ,min(trip_duration_min) trip_duration_min

      -- passengers
      ,sum(passenger_count) passenger_count_sum
      ,avg(passenger_count) passenger_count_avg
      ,max(passenger_count) passenger_count_max

      -- distance
      ,sum(trip_distance_km) trip_km_sum
      ,avg(trip_distance_km) trip_km_avg

      -- price / costs
      ,sum(fare_amount) fare_amount
      ,sum(extra) extra
      ,sum(mta_tax) mta_tax
      ,sum(tip_amount) tip_amount
      ,sum(tolls_amount) tolls_amount_sum
      ,sum(improvement_surcharge) improvement_surcharge
      ,sum(total_amount) total_amount_sum
      ,avg(total_amount) total_amount_avg

FROM {{ ref('silver_trips') }} as trips

GROUP BY
       VendorID
      ,pickup_date
      ,trips.DOLocationID
      ,trips.PULocationID
      ,payment_type
