connection: "romain_project"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: sub_station {}

explore: sub_status {}

explore: sub_trip {}

explore: sub_weather {}

explore:  full_picture {
  join: sub_station {}
  join: sub_status {}
  join: sub_trip {}
  join: sub_weather {}

}
