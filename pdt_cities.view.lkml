view: pdt_cities {
  derived_table: {
    sql:
      select
      start_station_name
      , sum(duration) as duration
      , rank() over (order by sum(duration) desc) as rank
      from sub_trip
      where
        {% condition rank_date_filter %} sub_trip.end_date {% endcondition %}
      group by 1
      ;;
    }

    filter: rank_date_filter {
      type: date
    }

    dimension: start_station_name {
      primary_key: yes
      type: string
      sql: ${TABLE}.start_station_name ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }


}
