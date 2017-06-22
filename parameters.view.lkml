view: playing_with_parameters {
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
    sql: CAST(${TABLE}.station_id AS INTEGER);;
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

  measure: count_index_param {
    type: count_distinct
#     sql: CASE WHEN ${status_date}= trim(both "'" from '{% parameter filter1 %}') THEN ${index} ELSE NULL END ;;
#       sql: CASE WHEN ${status_date}= replace({% parameter filter1 %}, "'", "") THEN ${index} ELSE NULL END ;;
      sql: CASE WHEN ${status_date}=DATE({% parameter filter1 %}) THEN ${index} ELSE NULL END ;;

#     filters: {
#           field: status_date
#           value: "{% parameter filter1 %}"
#         }
    }

  filter: filter1 {
    type: string
  }


  measure: count {
    type: count_distinct
    sql: ${index} ;;
    drill_fields: []
  }
}
