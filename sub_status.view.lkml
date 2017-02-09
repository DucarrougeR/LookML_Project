view: sub_status {
  sql_table_name: public.sub_status ;;

  dimension_group: time_info {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._time ;;
  }

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
    type: string
    sql: ${TABLE}.station_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
