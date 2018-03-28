view: just_to_test {
  sql_table_name: public.sub_trip ;;

  dimension: id {
    description: "is this description showing in https://localhost:19999/api/3.0/lookml_models/model1/explores/overall_picture "
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: bike_id {
    type: number
    sql: ${TABLE}.bike_id ;;
  }

  dimension: duration {
    label: "🕓"
    type: number
    sql: ${TABLE}.duration ;;
  }


  dimension: duration_tier_value_format {
    type: tier
    tiers: [0,1000,2000,3000,4000,5000,6000,7000,8000]
    style: integer
    value_format: "#,##0"
    sql: ${TABLE}.duration ;;
  }

#
#   dimension: duration_tier_value_name {
#     type: tier
#     tiers: [0,1000,2000,3000,4000,5000,6000,7000,8000]
#     style: integer
#     value_format_name: decimal_0
#     sql: ${TABLE}.duration ;;
#   }

  dimension_group: end_date {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour2,
      hour_of_day,
      day_of_week,
      day_of_month,
      month_name,
      month_num,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_date ;;
  }

  dimension_group: end {
    type: time
    timeframes: [raw, hour_of_day, month_name]
    sql: ${TABLE}.end_date ;;
  }

  dimension:time_periods {
    type: string
    sql: CASE WHEN CAST(${end_hour_of_day} AS INTEGER) in (7, 8, 9, 10, 11, 12, 13, 14) THEN '[7-15[ period'
          WHEN ${end_hour_of_day} in (15, 16) THEN '[15-17[ period'
          WHEN ${end_hour_of_day} in (17, 18) THEN '[17-19[ period'
          WHEN ${end_hour_of_day} in (19, 20, 21, 22) THEN '[19-23[ period'
          ELSE '[23-7[ period'
        END;;
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
      hour,
      hour2,
      hour_of_day,
      day_of_week,
      month_name,
      minute,
      minute15,
      date,
      time_of_day,
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
    drill_fields: [subscription_type, sub_station.location]
  }

  dimension: subscription_type {
    type: string
    sql: ${TABLE}.subscription_type ;;
  }

  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.zip_code;;
  }

  dimension: is_in_sf {
    type: yesno
    sql: ${zip_code} = ANY('{94102, 94103, 94104, 94105, 94107, 94108, 94109, 94110, 94111, 94112, 94114, 94115, 94116, 94117, 94118, 94121, 94122, 94123, 94124, 94127, 94129, 94130, 94131, 94132, 94133, 94134, 94158}') ;;
  }

  dimension: geo_map {
    sql: ${zip_code} ;;
    map_layer_name: identifier
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

  dimension: product_image {
    sql: CASE WHEN 1=1 THEN 'san-francisco' END;;
    html: <img src='https://www.dryfast.net/wp-content/uploads/2015/09/Dryfast-seal-of-city-and-county-of-san-francisco.jpg' width="100" height="100"/>;;
  }

  measure: count {
    type: count_distinct
    sql: ${id} ;;
  }

  measure: test_html_value {
    type: count_distinct
    sql: ${id} ;;

  html:
    <summary style="outline:none"> Dau: {{ count._rendered_value }}</summary>
    Total Dau: {{ avg_trip_time._value }}
    <summary style="outline:none"> Percentage: {{ count._linked_value }}</summary>
    <br/>;;
  }

  measure:avg_trip_time {
    description: "trip duration in seconds"
    type: average
    sql:  ${duration} ;;
  }


#####################
# TESTS
####################

  dimension: dimension_with_select {
    group_label: "Z Testing"
    type:  string
    sql:  SELECT ${TABLE}.duration ;;
  }

  measure: measure_with_select {
    group_label: "Z Testing"
    type:  number
    sql:  SELECT ${TABLE}.duration ;;
  }

  dimension: is_new_bike {
    type: yesno
    sql:  COUNT(${bike_id}) > 1 ;;
  }

  dimension: concat_test {
    type: string
    sql:  CONCAT(${end_month_name}, null, ${end_station_name}) ;;
  }

  measure: percent_value1 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }
  measure: percent_value2 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }
  measure: percent_value3 {
    type:  number
    sql:  random();;
    value_format: "0.00%"
  }

  dimension_group: date {
    type: time
    view_label: "Work date"
    label: "Work"
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    sql: ${TABLE}.DATE;;
    }

  measure: most_common_zone_code {
    type: string
    sql: (
      SELECT
      REPLACE((ARRAYAGG(zip_code) WITHIN GROUP (ORDER BY date DESC NULLS LAST) [0])::STRING,'"') AS most_common_zone
      FROM (
      SELECT
      driver_id
      , zip_code
      , SUM(sum_hours_worked) AS hrs
      FROM aggregate.agg_driver_shift_stats_daily_per_zone_per_driver agg
      WHERE {% condition start_raw %} agg.date {% endcondition %}

      GROUP BY 1,2
      ) a
      WHERE a.driver_id = ${TABLE}.driver_id
      );;
  }

  dimension: bike_id2 {
    group_label: "🎈Testing HTML"
    type: number
    value_format_name: id
    description: "The id of the school in Handshake"
    html: <a href="https://app.joinhandshake.com/schools/{{ value }}" target="_blank">Handshake School</a>
      ;;
    sql: ${TABLE}.bike_id ;;
  }

  dimension: end_station_id2 {
    group_label: "🎈Testing HTML"
    type: number
    value_format_name: id
    description: "The id of the school in Handshake"
    html: <a href="https://app.joinhandshake.com/schools/{{ value }}" target="_blank">Handshake School</a>
      ;;
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: show_russian {
    type: string
    sql: "человек и закон" ;;
  }

  dimension: testing_xlsx_decimal_download {
    description: "getting 000.000 UI data to download .xlsx and .csv"
    type: number
    sql: round((random()*10000000)::numeric,3) ;;
  }


  dimension: testing_emoji {
    label: "Testing Emoji 🎈"
    type:  number
    sql:
      CASE WHEN random() < 0.5 THEN "🎈"
      ELSE "🍾"
      END;;
  }

  dimension: random {
    type:  number
    sql:  round((random()*10000000)::numeric,3);;
  }

  measure: testing_list_measure {
    type:  list
    list_field: index
  }

#   dimension: testing_sql_param {
#     type:  string
#     sql :  ${TABLE}.end_station_name ;;
#   }

  dimension: testing_link_on_single_viz {
    type: number
    sql: ${TABLE}.bike_id ;;
    link: {
      label: "google search"
      url: "https://www.google.com"
    }
  }

  dimension: test_html_cell {
    type: string
    sql:  ${TABLE}.end_station_name ;;
    html:
     {% if row() =1 %}
        <div style="color: white; background-color: #CD5555; text-align:center"><font size="14%">{{ rendered_value }}</div>
       {% if value < 98 TOTAL' %}
      ;;
  }


  filter: created_in_last_days {
    label: "Filter orders for only so many days"
    suggestions: [
            "3 days ago for 1 day",
            "10 days ago for 7 days" ,
            "33 days ago for 30 days"
            ]
  }

  dimension: created_in_last_N_days {
    type: string
    sql:
      CASE
      WHEN
          substring(NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g'), '')
          from position(' ' in NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g')::varchar, ''))
          for char_length(NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g'), ''))
          )::int = 1
          THEN 'yesterday'
      ELSE
          CONCAT('last ', substring(NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g'), '')
          from position(' ' in NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g')::varchar, ''))
          for char_length(NULLIF(regexp_replace({% parameter created_in_last_days %}, '\D',' ','g'), ''))
          )::int, ' days')
        END ;;
  }

  dimension: dynamic_date_range {
    type:  string
    sql:  CASE
    WHEN ${start_date} BETWEEN current_date - 1 and current_date THEN 'yesterday'
    WHEN ${start_date} BETWEEN current_date - 7 and current_date -1 then 'last 7 days'
    WHEN ${start_date} BETWEEN current_date - 30 and current_date -7 then 'last 30 days'
    ELSE 'Older'
    END
    ;;
  }

  dimension: test_link_nosql{
    link: {
      label: "Lead Level Analysis"
      url: "https://google.com"
    }
  }

  dimension: name {
    description: "Not gonna work if not having field with same name in underlying table"
    link: {
      label: "Average Order Profit Look"
      url: "https://learn.looker.com/looks/249?&f[users.state]={{ _filters['users.state'] | url_encode }}"
    }
    link: {
      label: "User Facts Explore Explore"
      url: "https://learn.looker.com/explore/ecommerce/users?fields=users.id,users.name&f[users.state]={{ _filters['users.state'] | url_encode }}"
    }
  }

  measure: max_value {
    type:  max
    group_label: "HTML COLORING"
    hidden:  yes
    sql:  ${TABLE}.bike_id ;;
}

  measure: color_count {
    required_fields: [max_value]
    group_label: "HTML COLORING"
    type: count
    html:
    {% if value > max_value._value | times: 0.75 %}
      <font color="darkgreen">{{ rendered_value }}</font>
    {% elsif value > max_value._value | times: 0.6 %}
      <font color="orange">{{ rendered_value }}</font>
    {% else %}
      <font color="darkred">{{ rendered_value }}</font>
    {% endif %} ;;
  }


  measure: test {
    type: median
    value_format_name: decimal_1
    sql: DATEDIFF(MINUTE, ${start_raw}, ${end_raw})::FLOAT ;;
    group_label: "Timeliness"
    description: "Median Time (in minutes) taken for CS agents to fully resolved the tickets."
  }

  dimension: testing_webhook {
    description: "Webhook that will send email to looker Gmail"
    type: number
    sql: ${TABLE}.bike_id ;;
    action: {
      label: "Subscription is good to go"
      url: "https://hooks.zapier.com/hooks/catch/2705960/szgspt/"
      param: {
        name: "yeah"
        value: "{{ value }}"
      }
    }
  }

  dimension: sample_url {
    type:  string
    sql: 'www.google.com' ;;
  }

  dimension: test_link_sample_url {
    type: string
    sql: 'a link' ;;
    link: {
      label: "sweet link"
      # url: "${sample_url}" # NOT WORKING
      url: "{{sample_url._value}}"
    }
  }


parameter: testing_filter {

}

  parameter: param {
    label: "test param"
    type: string
    allowed_value: {
      label: "Object 1"
      value: "CL"
    }
    allowed_value: {
      label: "Object 2"
      value: "SO"
    }
    allowed_value: {
      label: "Object 3"
      value: "LH"
    }
  }

  dimension: instrument_name {
    sql: ${TABLE}.instrument_name ;;
  }

  dimension: new {
    sql:  CASE WHEN ${instrument_name} LIKE 'CL%%' AND ${instrument_name} NOT LIKE 'CL SO%' THEN 'Core Lab'
          WHEN ${instrument_name} LIKE 'CL SO%' OR ${instrument_name} LIKE '%send%out%' THEN 'Sent Out'
          ...
          else null end ;;
  }
}
