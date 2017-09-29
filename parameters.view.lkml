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


  # TESTING ###########################################################################
  # from https://discourse.looker.com/t/dynamic-date-filter-comparisons/5471
  filter: date_filter {
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
  }
  dimension_group: filter_start_date {
    type: time
    timeframes: [raw]
    sql: CASE WHEN {% date_start date_filter %} IS NULL THEN '1970-01-01' ELSE TO_TIMESTAMP(NULLIF({% date_start date_filter %}, 0)) END;;
  }

  dimension_group: filter_end_date {
    type: time
    timeframes: [raw]
    sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE TO_TIMESTAMP(NULLIF({% date_end date_filter %}, 0)) END;;
  }

  dimension: interval {
    type: number
    sql:  (${filter_start_date_raw} - ${filter_end_date_raw});;
  }

  dimension: previous_start_date {
    type: date
    # sql: DATEADD(minutes, -${interval}, ${filter_start_date_raw})*60 ;;
    sql: (${filter_start_date_raw} + -${interval}) ;;
  }

  dimension: timeframes {
    description: "Use this field in combination with the date filter field for dynamic date filtering"
    suggestions: ["period","previous period"]
  type: string
  case:  {
    when:  {
      sql: ${status_raw} BETWEEN ${filter_start_date_raw} AND  ${filter_end_date_raw};;
      label: "Period"
    }
    when: {
      sql: ${status_raw} BETWEEN ${previous_start_date} AND ${filter_start_date_raw} ;;
      label: "Previous Period"
    }
    else: "Not in time period"
  }
}
}
