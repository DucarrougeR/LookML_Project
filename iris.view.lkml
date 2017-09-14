view: iris {
  sql_table_name: public.iris ;;

  dimension: sepal_length {
    type:  number
    group_label: "Sepal"
    sql: ${TABLE}.sepal_length ;;
  }

  dimension: sepal_width {
    type:  number
    group_label: "Sepal"
    sql: ${TABLE}.sepal_width ;;
  }

  dimension: petal_length {
    type:  number
    group_label: "Petal"
    sql: ${TABLE}.petal_length ;;
  }

  dimension: petal_width {
    type:  number
    group_label: "Petal"
    sql: ${TABLE}.petal_width ;;
  }

  dimension: species {
    description: "Target"
    type:  string
    sql: ${TABLE}.species ;;
  }

  measure: count {
    type: count
  }
  measure: avg_sepal_length {
    type: average
    sql:  ${sepal_length} ;;
  }
  measure: avg_sepal_width {
    type: average
    sql:  ${sepal_width} ;;
  }
  measure: avg_petal_length {
    type: average
    sql:  ${petal_length} ;;
  }
  measure: avg_petal_width {
    type: average
    sql:  ${petal_width} ;;
  }


}
