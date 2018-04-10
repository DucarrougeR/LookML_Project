view: population_france_gps {
  sql_table_name: public.population_france_gps ;;

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: population {
    type: number
    sql: ${TABLE}.population ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
