view: sub_station {
  sql_table_name: public.sub_station ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.id AS INTEGER);;
  }


dimension: city_localized {
  label: "{% if _user_attributes['email'] == 'romain.ducarrouge@looker.com' %}
  Ville
  {% elsif _user_attributes['email'] == 'romainducarrouge@gmail.com' %}
  Ciudad
  {% else %}
  City
  {% endif %}"
  type: string
  sql: ${TABLE}.city ;;
}


  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: dock_count {
    type: number
    sql: ${TABLE}.dock_count ;;
  }

  dimension_group: installation {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.installation_date ;;
  }

  dimension: month_no_drill {
    # type: date
    sql: ${installation_month} ;;
    group_label: "Dates No Drill"
  }
  dimension: date_no_drill {
    # type: date
    sql: ${installation_date} ;;
    group_label: "Dates No Drill"
  }
  dimension: year_no_drill {
    # type: date
    sql: ${installation_year} ;;
    group_label: "Dates No Drill"
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.lat ;;
    sql_longitude: ${TABLE}.lng ;;
  }


  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: station_count {
    type: count
    drill_fields: [id, name]
  }

  set: station_set {
    fields: [id, dock_count]
  }
}
