view: pdt_rank_test {

  derived_table: {
    sql: select rank() over (order by sum(duration) desc) as rank from sub_trip ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }

}
