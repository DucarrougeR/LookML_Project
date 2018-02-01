view: testing_pdt_with_persist_and_trigger {
derived_table: {
  sql:
      select
      start_station_name
      , sum(duration) as duration
      from sub_trip
      group by 1
      ;;
  sql: select * from sub_trip ;;
  indexes: ["start_station_name"]
  # sql_trigger_value: SELECT current_date ;;
  persist_for: "4 hours"

}



dimension: start_station_name {
  primary_key: yes
  type: string
  sql: ${TABLE}.start_station_name ;;
}

dimension: duration {}


}
