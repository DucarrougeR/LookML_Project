view: test_dt_tf {
  derived_table: {
    sql:
    select * from sub_station
    where {% condition id_filter %} sub_station.id {% endcondition %}
    ;;
  }

  filter: id_filter {
    type: number
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: test_dt_tf.id;;
  }

  dimension: city {
    type: string
    sql: test_dt_tf.city ;;
  }

  dimension: dock_count {
    type: number
    sql: test_dt_tf.dock_count ;;
  }


  }
