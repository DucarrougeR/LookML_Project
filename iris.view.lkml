view: iris {
  sql_table_name: public.iris ;;

  dimension: sepal_length {
    type:  number
    group_label: "Sepal"
    sql: ${TABLE}.sepal_length ;;
  }

  dimension: sepal_width {
    type:  number
    group_label: "Sepal"
    sql: ${TABLE}.sepal_width ;;
  }

  dimension: petal_length {
    type:  number
    group_label: "Petal"
    sql: ${TABLE}.petal_length ;;
  }

  dimension: petal_width {
    type:  number
    group_label: "Petal"
    sql: ${TABLE}.petal_width ;;
  }

  dimension: species {
    description: "Target"
    type:  string
    sql: ${TABLE}.species ;;
  }

  measure: count {
    type: count
  }
  measure: avg_sepal_length {
    type: average
    sql:  ${sepal_length} ;;
  }
  measure: avg_sepal_width {
    type: average
    sql:  ${sepal_width} ;;
  }
  measure: avg_petal_length {
    type: average
    sql:  ${petal_length} ;;
  }
  measure: avg_petal_width {
    type: average
    sql:  ${petal_width} ;;
  }


# Define filter to use Parameter in Measures
filter: feature_to_explore {
  type: string
  suggestions: ["Petal Width", "Petal Length", "Sepal Width", "Sepal Length", "Petal", "Sepal", "Length", "Width"]
  }

  measure: correlation {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} = 'Petal' then corr(${petal_length}, ${petal_width})::varchar
          when {% parameter feature_to_explore %} = 'Sepal' then corr(${sepal_length}, ${sepal_width})::varchar
          when {% parameter feature_to_explore %} = 'Width' then corr(${sepal_width}, ${petal_width})::varchar
          when {% parameter feature_to_explore %} = 'Length' then corr(${petal_length}, ${sepal_length})::varchar
          else 'choose: `Petal`, `Sepal`, `Width`, `Length` as filter value'
        end ;;
  }

  measure: standard_deviation_population {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} = 'Petal Width' then stddev_pop(${petal_length})
          when {% parameter feature_to_explore %} = 'Petal Length' then stddev_pop(${petal_width})
          when {% parameter feature_to_explore %} = 'Sepal Width' then stddev_pop(${sepal_width})
          when {% parameter feature_to_explore %} = 'Sepal Length' then stddev_pop(${sepal_length})
        end ;;
  }

  measure: variance_population {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} = 'Petal Width' then var_pop(${petal_length})
          when {% parameter feature_to_explore %} = 'Petal Length' then var_pop(${petal_width})
          when {% parameter feature_to_explore %} = 'Sepal Width' then var_pop(${sepal_width})
          when {% parameter feature_to_explore %} = 'Sepal Length' then var_pop(${sepal_length})
        end ;;
  }

  measure: modal_value {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} = 'Petal Width' then mode(${petal_length}) WITHIN GROUP (ORDER BY ${species})
          when {% parameter feature_to_explore %} = 'Petal Length' then mode(${petal_width}) WITHIN GROUP (ORDER BY ${species})
          when {% parameter feature_to_explore %} = 'Sepal Width' then mode(${sepal_width}) WITHIN GROUP (ORDER BY ${species})
          when {% parameter feature_to_explore %} = 'Sepal Length' then mode(${sepal_length}) WITHIN GROUP (ORDER BY ${species})
        end ;;
  }

  measure: Intercept_Reg {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} ILIKE 'Petal' then regr_intercept(${petal_length}, ${petal_width})
          when {% parameter feature_to_explore %} ILIKE 'Sepal' then regr_intercept(${sepal_width}, ${sepal_length})
        end ;;
  }
  measure: R_squared {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} ILIKE 'Petal' then regr_r2(${petal_length}, ${petal_width})
          when {% parameter feature_to_explore %} ILIKE 'Sepal' then regr_r2(${sepal_width}, ${sepal_length})
        end ;;
  }
  measure: Slope {
    type: string
    group_label: "Stats"
    sql:
       case
          when {% parameter feature_to_explore %} ILIKE 'Petal' then regr_slope(${petal_length}, ${petal_width})
          when {% parameter feature_to_explore %} ILIKE 'Sepal' then regr_slope(${sepal_width}, ${sepal_length})
        end ;;
  }


  measure: count_sepal_GAUGE {
    group_label: "Google chart API"
    type: number
    sql: AVG(${sepal_length})*100 / MAX(${sepal_length}) ;;
    html: <img src="https://chart.googleapis.com/chart?chs=500x300&cht=gom&chxt=y&chco=d84341,efb30e,f2f210,6fe043&chf=bg,s,FFFFFF00&chd=t:{{ value }}"/> ;;
  }
  measure: count_sepal_value {
    group_label: "Google chart API"
    type: number
    sql: AVG(${sepal_length})*100 / MAX(${sepal_length}) ;;
  }

  measure: test_dble_pie {
    group_label: "Google chart API"
    type:  number
    sql:  ${avg_sepal_width} ;;
    html: <img src="http://chart.apis.google.com/chart?cht=pc&chs=500x250&chdl=first+legend%7Csecond+legend%7Cthird+legend|legend+four%7Clegend+five%7Clegend+six&chl=first+label%7Csecond+label%7Cthird+label|label+four%7Clabel+five%7Clabel+six&chco=FF0000|00FFFF|00FF00,6699CC|CC33FF|CCCC33&chtt=My+Google+Chart&chts=000000,24&chd=t:5,10,50|25,35,45" /> ;;
  }

  measure: test_3d_pie {
    group_label: "Google chart API"
    type: average
    sql: ${sepal_length} ;;
    html: <img src="http://chart.apis.google.com/chart?cht=p3&chs=500x250&chdl=first+legend%7Csecond+legend%7Cthird+legend&chl=first+label%7Csecond+label%7Cthird+label&chco=FF0000|00FFFF|00FF00,6699CC|CC33FF|CCCC33&chtt=My+Google+Chart&chts=000000,24&chd=t:5,10,50|25,35,45" /> ;;
  }

  measure: test_bar_chart {
    group_label: "Google chart API"
    type:  average
    sql:  ${sepal_length} ;;
    html: <img src="http://chart.apis.google.com/chart?cht=lc&chf=FFE7C6&chs=500x250&chco=6699CC,CC33FF,CCCC33&chxt=x,y&chxr=0,-20,100|1,0,50&chdl=first+legend%7Csecond+legend%7Cthird+legend&chtt=My+Google+Chart&chts=000000,24&chd=t:5,10,50|25,35,45" />;;
  }
}
