# view: test_pdt_api {
#   derived_table: {
#     sql:
#       select * from public.sub_trip
#       join public.sub_station
#       on public.sub_trip.start_station_id = public.substation.id ;;

#       sql_trigger_value: SELECT current_date ;;
#   }


#   dimension: random {
#     type:  number
#     value_format_name: decimal_4
#     sql: random() ;;
#   }

# }
