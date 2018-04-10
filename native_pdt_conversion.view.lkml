view: native_pdt_conversion {
    derived_table: {
      sql:
      select
      sub_trip.start_station_name
      , sum(sub_trip.duration) as duration
      , sub_station.dock_count as dock_count
      , sub_station.city as city
      from sub_trip
      join sub_station
      on sub_trip.start_station_id::int = sub_station.id::int
      group by 1,3,4
      ;;
    }

    filter: station_name {
      type: string
    }

    dimension: start_station_name {
      primary_key: yes
      type: string
      sql: ${TABLE}.start_station_name ;;
    }

    dimension: duration {
      type: number
      sql: ${TABLE}.duration ;;
    }

  dimension: dock_count {
    type: number
    sql: ${TABLE}.dock_count ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  measure: count {
    type:  count
  }
}
