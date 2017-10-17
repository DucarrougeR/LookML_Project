view: sub_trip {
  sql_table_name: public.sub_trip ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: bike_id {
    type: number
    sql: ${TABLE}.bike_id ;;
  }

  dimension: duration {
    label: "🕓"
    type: number
    sql: ${TABLE}.duration ;;
  }

#
  dimension: duration_tier_value_format {
    type: tier
    tiers: [0,1000,2000,3000,4000,5000,6000,7000,8000]
    style: integer
    value_format: "#,##0"
    sql: ${TABLE}.duration ;;
  }
#
#   dimension: duration_tier_value_name {
#     type: tier
#     tiers: [0,1000,2000,3000,4000,5000,6000,7000,8000]
#     style: integer
#     value_format_name: decimal_0
#     sql: ${TABLE}.duration ;;
#   }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour2,
      hour_of_day,
      day_of_week,
      day_of_month,
      month_name,
      month_num,
      millisecond,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_date ;;
  }

#   dimension_group: end {
#     type: time
#     timeframes: [raw]
#     sql: ${TABLE}.end_date ;;
#   }

  dimension:time_periods {
    type: string
    sql: CASE WHEN CAST(${end_hour_of_day} AS INTEGER) in (7, 8, 9, 10, 11, 12, 13, 14) THEN '[7-15[ period'
          WHEN ${end_hour_of_day} in (15, 16) THEN '[15-17[ period'
          WHEN ${end_hour_of_day} in (17, 18) THEN '[17-19[ period'
          WHEN ${end_hour_of_day} in (19, 20, 21, 22) THEN '[19-23[ period'
          ELSE '[23-7[ period'
        END;;
  }

#           CASE
#           WHEN (${end_hour_of_day} >= 7 AND ${end_hour_of_day} < 15) THEN "7-15 period"
#           WHEN (${end_hour_of_day} >= 15 AND ${end_hour_of_day} < 17) THEN "15-17 period"
#           WHEN (${end_hour_of_day} >= 17 AND ${end_hour_of_day} < 19) THEN "17-19 period"
#           WHEN (${end_hour_of_day} <= 19 AND ${end_hour_of_day} < 23) THEN "19-23 period"
#           ELSE "23-7 period"
#         END;;

  dimension: end_station_id {
    type: string
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: end_station_name {
    type: string
    sql: ${TABLE}.end_station_name ;;
  }

  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour2,
      hour_of_day,
      day_of_week,
      month_name,
      minute,
      minute15,
      date,
      time_of_day,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_date ;;
  }

  dimension: start_station_id {
    type: string
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: start_station_name {
    type: string
    sql: ${TABLE}.start_station_name ;;
    drill_fields: [subscription_type, sub_station.location]
  }

  dimension: subscription_type {
    type: string
    sql: ${TABLE}.subscription_type ;;
  }

  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.zip_code;;
  }

  dimension: is_in_sf {
    type: yesno
    sql: ${zip_code} = ANY('{94102, 94103, 94104, 94105, 94107, 94108, 94109, 94110, 94111, 94112, 94114, 94115, 94116, 94117, 94118, 94121, 94122, 94123, 94124, 94127, 94129, 94130, 94131, 94132, 94133, 94134, 94158}') ;;
    link: {
      url: "https://localhost:9999/dashboards/2"
    }
  }

  dimension: geo_map {
    sql: ${zip_code} ;;
    map_layer_name: identifier
  }

  dimension: neighborhood {
    type:  string
    sql: CASE WHEN ${zip_code} = '94129' THEN 'Presidio'
              WHEN ${zip_code} = '94123' THEN 'Marina'
              WHEN ${zip_code} = '94109' THEN 'Russian Hill'
              WHEN ${zip_code} = '94133' THEN 'North Beach'
              WHEN ${zip_code} = '94108' THEN 'Union Square'
              WHEN ${zip_code} = '94111' THEN 'Financial District'
              WHEN ${zip_code} = '94115' THEN 'Western Addition'
              WHEN ${zip_code} = '94118' THEN 'Inner Richmond'
              WHEN ${zip_code} = '94121' THEN 'Outer Richmond'
              WHEN ${zip_code} = '94122' THEN 'Sunset'
              WHEN ${zip_code} = '94116' THEN 'Lake Merced'
              WHEN ${zip_code} = '94132' THEN 'Lake Shore'
              WHEN ${zip_code} = '94102' THEN 'Castro'
              WHEN ${zip_code} = '94117' THEN 'Haight Ashbury'
              WHEN ${zip_code} = '94105' THEN 'SOMA'
              WHEN ${zip_code} = '94103' THEN 'Civic Center'
              WHEN ${zip_code} = '94124' THEN 'Bayview'
              WHEN ${zip_code} = '94159' THEN 'Portrero Hill'
              WHEN ${zip_code} = '94110' THEN 'Mission'
              WHEN ${zip_code} = '94114' THEN 'Presidio'
              WHEN ${zip_code} = '94131' THEN 'Forest Hill'
              WHEN ${zip_code} = '94107' THEN 'Mission Bay'
              WHEN ${zip_code} = '94158' THEN 'Dogpatch'
              ELSE NULL END
              ;;
  }

  dimension: product_image {
    sql: CASE WHEN 1=1 THEN 'san-francisco' END;;
      html: <img src='https://www.dryfast.net/wp-content/uploads/2015/09/Dryfast-seal-of-city-and-county-of-san-francisco.jpg' width="100" height="100"/>;;
  }

  dimension: image_link {
    type:  string
    sql:
        CASE WHEN 1=1 THEN  'https://www.dryfast.net/wp-content/uploads/2015/09/Dryfast-seal-of-city-and-county-of-san-francisco.jpg'
        END ;;
    }
  dimension: avatar_image {
      sql: ${image_link} ;;
      html: <img src='{{ rendered_value }}' width="75px" />
        ;;
  }

  measure: count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [neighborhood]

  }

  measure:avg_trip_time {
    description: "trip duration in seconds"
    type: average
    sql:  ${duration} ;;
  }

# NEED TO CHECK THIS MEASURE ON MONDAY TO GET THE REVENUE WORKING
# NEED TO MAKE A MONTH TO MONTH COMPARISON OF REVENUE
  measure: revenue {
    type: sum
    sql:  CASE WHEN ${duration} < 1800 THEN 0
               WHEN ${duration} BETWEEN 1800 AND 3600 THEN 4
               WHEN ${duration} > 3600 THEN ((${sub_trip.duration}-3600)/1800 *7 + 4)
          END;;
    value_format_name: usd
  }



}
