# include: "sub_trip.view.lkml"
# include: "sub_station.view.lkml"
# include: "sub*"
# include: " model1.model.lkml"
#
# view: test_ndt {
#   derived_table: {
#     explore_source: overall_picture {
#       column: revenue { field: sub_trip.revenue }
#       column: name { field: sub_station.name }
#     }
#   }
#   dimension: revenue {}
#   dimension: name {}
# }
