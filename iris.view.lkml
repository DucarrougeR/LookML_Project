view: iris {
  sql_table_name: public.iris ;;

  dimension: sepal_length {
  type:  number
  sql: ${TABLE}. ;;
  }

  dimension: sepal_width {
  type:  number
  sql: ${TABLE} ;;
  }

  dimension: petal_length {
  type:  number
  sql: ${TABLE}. ;;
  }

  dimension: petal_width {
  type:  number
  sql: ${TABLE}. ;;
  }

  dimension: species {
  type:  string
  sql: ${TABLE}. ;;
  }

}
