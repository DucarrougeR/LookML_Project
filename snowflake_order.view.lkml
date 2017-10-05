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

  }
