view: sub_status {
  sql_table_name: public.sub_status ;;

  dimension: bikes_available {
    type: number
    sql: ${TABLE}.bikes_available ;;
  }

  dimension: docks_available {
    type: number
    sql: ${TABLE}.docks_available ;;
  }

  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }

  dimension: station_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.station_id ;;
  }

  dimension_group: status {
    type: time
    timeframes: [
      raw,
      day_of_week,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.status_time ;;
  }

  measure: count {
    type: count_distinct
    sql: ${index} ;;
    drill_fields: []
  }
}
