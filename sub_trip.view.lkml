view: sub_trip {
  sql_table_name: public.sub_trip ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: bike_id {
    type: number
    sql: ${TABLE}.bike_id ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_date ;;
  }

  dimension: end_station_id {
    type: string
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: end_station_name {
    type: string
    sql: ${TABLE}.end_station_name ;;
  }

  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_date ;;
  }

  dimension: start_station_id {
    type: string
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: start_station_name {
    type: string
    sql: ${TABLE}.start_station_name ;;
  }

  dimension: subscription_type {
    type: string
    sql: ${TABLE}.subscription_type ;;
  }

  dimension: zip_code {
    type: string
    sql: ${TABLE}.zip_code;;
  }

  dimension: is_in_sf {
    type: yesno
    sql: ${zip_code} = ANY('{94102, 94103, 94104, 94105, 94107, 94108, 94109, 94110, 94111, 94112, 94114, 94115, 94116, 94117, 94118, 94121, 94122, 94123, 94124, 94127, 94129, 94130, 94131, 94132, 94133, 94134, 94158}') ;;
  }

  dimension: geo_map {
    map_layer_name: identifier
    sql: ${zip_code} ;;
  }

  dimension: neighborhood {
    type:  string
    sql: CASE WHEN ${zip_code} = '94129' THEN 'Presidio'
              WHEN ${zip_code} = '94123' THEN 'Marina'
              WHEN ${zip_code} = '94109' THEN 'Russian Hill'
              WHEN ${zip_code} = '94133' THEN 'North Beach'
              WHEN ${zip_code} = '94108' THEN 'Union Square'
              WHEN ${zip_code} = '94111' THEN 'Financial District'
              WHEN ${zip_code} = '94115' THEN 'Western Addition'
              WHEN ${zip_code} = '94118' THEN 'Inner Richmond'
              WHEN ${zip_code} = '94121' THEN 'Outer Richmond'
              WHEN ${zip_code} = '94122' THEN 'Sunset'
              WHEN ${zip_code} = '94116' THEN 'Lake Merced'
              WHEN ${zip_code} = '94132' THEN 'Lake Shore'
              WHEN ${zip_code} = '94102' THEN 'Castro'
              WHEN ${zip_code} = '94117' THEN 'Haight Ashbury'
              WHEN ${zip_code} = '94105' THEN 'SOMA'
              WHEN ${zip_code} = '94103' THEN 'Civic Center'
              WHEN ${zip_code} = '94124' THEN 'Bayview'
              WHEN ${zip_code} = '94159' THEN 'Portrero Hill'
              WHEN ${zip_code} = '94110' THEN 'Mission'
              WHEN ${zip_code} = '94114' THEN 'Presidio'
              WHEN ${zip_code} = '94131' THEN 'Forest Hill'
              WHEN ${zip_code} = '94107' THEN 'Mission Bay'
              WHEN ${zip_code} = '94158' THEN 'Dogpatch'
              ELSE NULL END
              ;;
  }

  measure: count {
    type: count
    drill_fields: [id, end_station_name, start_station_name]
  }

  measure:avg_trip_time {
    type: average
    sql:  ${duration} ;;
  }

  measure: avg_count {
    type: average
    sql: ${start_time} ;;
  }
}
