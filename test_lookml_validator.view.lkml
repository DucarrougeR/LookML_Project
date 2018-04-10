view: test_lookml_validator {
    sql_table_name: public.sub_trip ;;

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: bike_id_BREAKING {
      type: number
      sql: ${NotExistingTable.bike_id} ;;
    }

    dimension: bike_id_NOTBREAKING {
      type: number
      sql:  CASE WHEN 1 > 0 THEN ${NotExistingTable.bike_id}
            ELSE null;;
    }
  }
