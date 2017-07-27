view: just_to_test {
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

  measure: count {
    type: count_distinct
    sql: ${id} ;;
  }

  measure:avg_trip_time {
    description: "trip duration in seconds"
    type: average
    sql:  ${duration} ;;
  }


#####################
# TESTS
####################

  dimension: dimension_with_select {
    group_label: "Z Testing"
    type:  string
    sql:  SELECT ${TABLE}.duration ;;
  }

  measure: measure_with_select {
    group_label: "Z Testing"
    type:  number
    sql:  SELECT ${TABLE}.duration ;;
  }

  dimension: is_new_bike {
    type: yesno
    sql:  COUNT(${bike_id}) > 1 ;;
  }

  dimension: concat_test {
    type: string
    sql:  CONCAT(${end_month_name}, null, ${end_station_name}) ;;
  }

  measure: percent_value1 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }
  measure: percent_value2 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }
  measure: percent_value3 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }

  dimension_group: date {
    type: time
    view_label: "Work date"
    label: "Work"
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    sql: ${TABLE}.DATE;;
    }

  measure: most_common_zone_code {
    type: string
    sql: (
      SELECT
      REPLACE((ARRAYAGG(zip_code) WITHIN GROUP (ORDER BY date DESC NULLS LAST) [0])::STRING,'"') AS most_common_zone
      FROM (
      SELECT
      driver_id
      , zip_code
      , SUM(sum_hours_worked) AS hrs
      FROM aggregate.agg_driver_shift_stats_daily_per_zone_per_driver agg
      WHERE {% condition start_raw %} agg.date {% endcondition %}

      GROUP BY 1,2
      ) a
      WHERE a.driver_id = ${TABLE}.driver_id
      );;
  }

  dimension: bike_id2 {
    group_label: "🎈Testing HTML"
    type: number
    value_format_name: id
    description: "The id of the school in Handshake"
    html: <a href="https://app.joinhandshake.com/schools/{{ value }}" target="_blank">Handshake School</a>
      ;;
    sql: ${TABLE}.bike_id ;;
  }

  dimension: end_station_id2 {
    group_label: "🎈Testing HTML"
    type: number
    value_format_name: id
    description: "The id of the school in Handshake"
    html: <a href="https://app.joinhandshake.com/schools/{{ value }}" target="_blank">Handshake School</a>
      ;;
    sql: ${TABLE}.end_station_id ;;
  }

}
