view: sub_weather {
  sql_table_name: public.sub_weather ;;

  dimension: cloud_cover {
    type: number
    sql: ${TABLE}.cloud_cover ;;
  }

  dimension: events {
    type: string
    sql: CASE WHEN ${TABLE}.events is null THEN 'Normal'
              WHEN ${TABLE}.events = 'rain' THEN 'Rain'
              ELSE ${TABLE}.events
              END;;
  }

  dimension: index {
    type: number
    hidden:  yes
    sql: ${TABLE}.index ;;
  }

  dimension_group: weather {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.weather_date ;;
  }

  dimension: wind_dir_degrees {
    type: number
    sql: ${TABLE}.wind_dir_degrees ;;
  }

  dimension: zip_code {
    type: string
    sql: ${TABLE}.zip_code ;;
  }

  dimension: mean_temperature_f {
    type: number
    sql: ${TABLE}.mean_temperature_f ;;
  }

  dimension:  is_week_day {
    type:  yesno
    sql: ${weather_day_of_week} = ANY('{Monday, Tuesday, Wednesday, Thursday, Friday}') ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure:  avg_temp {
    type:  average
    sql:  ${mean_temperature_f} ;;
  }

  measure: measure_mean_temp {
    type: number
    sql: ${mean_temperature_f} ;;
  }

  measure: max_gust_speed_mph {
    type: max
    sql: ${TABLE}.max_gust_speed_mph ;;
  }

  measure: max_humidity {
    type: max
    sql: ${TABLE}.max_humidity ;;
  }

  measure: max_temperature_f {
    type: max
    sql: ${TABLE}.max_temperature_f ;;
  }

  measure: max_visibility_miles {
    type: max
    sql: ${TABLE}.max_visibility_miles ;;
  }

  measure: max_wind_speed_mph {
    type: max
    sql: ${TABLE}.max_wind_speed_mph ;;
  }
  measure: min_humidity {
    type: min
    sql: ${TABLE}.min_humidity ;;
  }

  measure: min_temperature_f {
    type: min
    sql: ${TABLE}.min_temperature_f ;;
  }

  measure: min_visibility_miles {
    type: min
    sql: ${TABLE}.min_visibility_miles ;;
  }

  measure: avg_humidity {
    type: average
    sql: ${TABLE}.mean_humidity ;;
  }

  measure: avg_wind_speed_mph {
    type: average
    sql: ${TABLE}.mean_wind_speed_mph ;;
  }
}
