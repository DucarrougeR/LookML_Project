view: snowflake_order {
  sql_table_name: LOOKER_TEST.ORDERS ;;


  dimension: id {}
  dimension: status {}
  dimension: user_id {}
  dimension: order_amount {}
  dimension_group: created_at {
    type: time
    timeframes: [year, month, month_name, week, week_of_year, date, day_of_week, minute]
  }

  # NOT WORKING as on Looker 5
  # measure: list_status {
  #   type: list
  #   list_field: status
  # }

  measure: list_measure {
    type:  string
    sql: LISTAGG(${status}, ' ') ;;
  }

  measure: list_distinct_measure {
    type:  string
    sql: LISTAGG(DISTINCT ${status}, ' ') ;;
  }
  }
