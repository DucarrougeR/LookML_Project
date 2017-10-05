connection: "looker_project"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: daily_update {
  sql_trigger: SELECT current_date ;;
  max_cache_age: "23 hours"
}



map_layer: identifier {
  file: "Bay_Area_Project.json"
  property_key: "ZCTA5CE10"
  }

# https://cdn.rawgit.com/DucarrougeR/d4d88407dc8cc76813d25e1879352ea1/raw/1f5fac16d0b71ec68ad6e281d554467f6dee4a99/Bay_Area_Project.json
# property_key: "ZCTA5CE10"

explore: overall_picture {
  persist_with: daily_update
  view_name: sub_trip {
    sql_always_where: LENGTH(${sub_trip.zip_code}) = 5
    AND (${sub_trip.zip_code} LIKE '94%' OR ${sub_trip.zip_code} LIKE '95%');;

  }
  join: sub_station {
    sql_on: ${sub_trip.start_station_id} = ${sub_station.id} ;;
    relationship: many_to_one
  }

  join: sub_status {
    sql_on: ${sub_trip.start_station_id} = ${sub_status.station_id} ;;
    relationship:  many_to_one
  }

  join: sub_weather {
    sql_on: ${sub_trip.start_date} = ${sub_weather.weather_date} ;;
    relationship:  many_to_one

  }
}

explore: sub_station {}

explore: sub_weather {
  # make sure that it is a real zip code, and that it is in California (starts with 9)
  sql_always_where: LENGTH(${zip_code}) = 5 AND (${zip_code} LIKE '94%' OR ${zip_code} LIKE '95%');;
  }

explore:  sub_status {}

explore:  sub_trip {
  # make sure that it is a real zip code, and that it is in California (starts with 9)
  sql_always_where: LENGTH(${zip_code}) = 5 AND (${zip_code} LIKE '94%' OR ${zip_code} LIKE '95%');;
}

explore: pdt_cities{
  label: "Test Postgres Ranking"
}

explore: playing_with_parameters{
  label: "Parameters"
}


explore: pdt_rank_test {
  label:  "pdt rank test"
  group_label: "TEST"
}

explore: test_dt_tf {
  label: "Z test dt tf"
  group_label: "TEST"
}

explore: just_to_test {
  label: "Z just to test"
  group_label: "TEST"
}

explore: native_pdt_conversion {
  label: "Testing Native PDT"
  group_label: "TEST"
}

# explore: test_pdt_api {
#   label: "Testing run_query in API for PDT"
#   group_label: "TEST"
# }
