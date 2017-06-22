view: pdt_rank_test {

  derived_table: {
    sql: select rank() over (order by sum(duration) desc) as rank  ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }

}
