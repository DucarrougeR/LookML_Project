connection: "snowflake"

include: "snowflake_order.view.lkml"
include: "snowflake_user.view.lkml"
# include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: snowflake_user {
  label: "SnowFlake Model"

  join: snowflake_order {
    relationship: many_to_one
    sql_on: ${snowflake_user.id} = ${snowflake_order.user_id} ;;
  }
}
