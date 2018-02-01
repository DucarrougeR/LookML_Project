# If necessary, uncomment the line below to include explore_source.
# include: "snowflake_model.model.lkml"

view: testing {
  derived_table: {
    explore_source: snowflake_user {
      column: id { field: snowflake_order.id }
      column: name {}
    }
    sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from GETDATE()) - 60*60*3)/(60*60*24)) ;;
    indexes: ["snowflake_user"]
  }
  dimension: id {}
  dimension: name {}
}
