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

  dimension: max_dew_point_f {
    type: number
    hidden: yes
    sql: ${TABLE}.max_dew_point_f ;;
  }

  dimension: max_gust_speed_mph {
    type: number
    sql: ${TABLE}.max_gust_speed_mph ;;
  }

  dimension: max_humidity {
    type: number
    sql: ${TABLE}.max_humidity ;;
  }

  dimension: max_sea_level_pressure_inches {
    type: number
    sql: ${TABLE}.max_sea_level_pressure_inches ;;
  }

  dimension: max_temperature_f {
    type: number
    sql: ${TABLE}.max_temperature_f ;;
  }

  dimension: max_visibility_miles {
    type: number
    sql: ${TABLE}.max_visibility_miles ;;
  }

  dimension: max_wind_speed_mph {
    type: number
    sql: ${TABLE}.max_wind_speed_mph ;;
  }

  dimension: mean_dew_point_f {
    type: number
    sql: ${TABLE}.mean_dew_point_f ;;
  }

  dimension: mean_humidity {
    type: number
    sql: ${TABLE}.mean_humidity ;;
  }

  dimension: mean_sea_level_pressure_inches {
    type: number
    sql: ${TABLE}.mean_sea_level_pressure_inches ;;
  }

  dimension: mean_visibility_miles {
    type: number
    sql: ${TABLE}.mean_visibility_miles ;;
  }

  dimension: mean_wind_speed_mph {
    type: number
    sql: ${TABLE}.mean_wind_speed_mph ;;
  }

  dimension: min_dew_point_f {
    type: number
    sql: ${TABLE}.min_dew_point_f ;;
  }

  dimension: min_humidity {
    type: number
    sql: ${TABLE}.min_humidity ;;
  }

  dimension: min_sea_level_pressure_inches {
    type: number
    sql: ${TABLE}.min_sea_level_pressure_inches ;;
  }

  dimension: min_temperature_f {
    type: number
    sql: ${TABLE}.min_temperature_f ;;
  }

  dimension: min_visibility_miles {
    type: number
    sql: ${TABLE}.min_visibility_miles ;;
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

  measure: count {
    type: count
    drill_fields: []
  }

  measure: measure_mean_temp {
    type: number
    sql: ${mean_temperature_f} ;;
  }
}
