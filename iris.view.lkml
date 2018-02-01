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
  dimension: petal_length_tiered {
    type:  tier
    style:  classic
    tiers: [0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0]
    group_label: "Petal"
    sql: ${TABLE}.petal_length ;;
    hidden:  yes
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
    html: <img src="http://chart.apis.google.com/chart?cht=p3&chs=500x250&chdl=first+legend%7Csecond+legend%7Cthird+legend&chl=first+label%7Csecond+label%7Cthird+label&chco=FF0000|00FFFF|00FF00,6699CC|CC33FF|CCCC33&chtt=My+Sweet+Pie&chts=000000,24&chd=t:5,10,50|25,35,45" /> ;;
  }

  measure: test_bar_chart {
    group_label: "Google chart API"
    type:  average
    sql:  ${sepal_length} ;;
    html: <img src="http://chart.apis.google.com/chart?cht=lc&chf=FFE7C6&chs=500x250&chco=6699CC,CC33FF,CCCC33&chxt=x,y&chxr=0,-20,100|1,0,50&chdl=first+legend%7Csecond+legend%7Cthird+legend&chtt=My+Google+Chart&chts=000000,24&chd=t:5,10,50|25,35,45" />;;
  }

  dimension: country_code {
    sql:  'col' ;;
    # sql:
      # CASE
      # WHEN ${TABLE}.geo_country = 'AF' THEN 'AFG'
      # WHEN ${TABLE}.geo_country = 'AX' THEN 'ALA'
      # WHEN ${TABLE}.geo_country = 'AL' THEN 'ALB'
      # WHEN ${TABLE}.geo_country = 'DZ' THEN 'DZA'
      # WHEN ${TABLE}.geo_country = 'AS' THEN 'ASM'
      # WHEN ${TABLE}.geo_country = 'AD' THEN 'AND'
      # WHEN ${TABLE}.geo_country = 'AO' THEN 'AGO'
      # WHEN ${TABLE}.geo_country = 'AI' THEN 'AIA'
      # WHEN ${TABLE}.geo_country = 'AQ' THEN 'ATA'
      # WHEN ${TABLE}.geo_country = 'AG' THEN 'ATG'
      # WHEN ${TABLE}.geo_country = 'AR' THEN 'ARG'
      # WHEN ${TABLE}.geo_country = 'AM' THEN 'ARM'
      # WHEN ${TABLE}.geo_country = 'AW' THEN 'ABW'
      # WHEN ${TABLE}.geo_country = 'AU' THEN 'AUS'
      # WHEN ${TABLE}.geo_country = 'AT' THEN 'AUT'
      # WHEN ${TABLE}.geo_country = 'AZ' THEN 'AZE'
      # WHEN ${TABLE}.geo_country = 'BS' THEN 'BHS'
      # WHEN ${TABLE}.geo_country = 'BH' THEN 'BHR'
      # WHEN ${TABLE}.geo_country = 'BD' THEN 'BGD'
      # WHEN ${TABLE}.geo_country = 'BB' THEN 'BRB'
      # WHEN ${TABLE}.geo_country = 'BY' THEN 'BLR'
      # WHEN ${TABLE}.geo_country = 'BE' THEN 'BEL'
      # WHEN ${TABLE}.geo_country = 'BZ' THEN 'BLZ'
      # WHEN ${TABLE}.geo_country = 'BJ' THEN 'BEN'
      # WHEN ${TABLE}.geo_country = 'BM' THEN 'BMU'
      # WHEN ${TABLE}.geo_country = 'BT' THEN 'BTN'
      # WHEN ${TABLE}.geo_country = 'BO' THEN 'BOL'
      # WHEN ${TABLE}.geo_country = 'BQ' THEN 'BES'
      # WHEN ${TABLE}.geo_country = 'BA' THEN 'BIH'
      # WHEN ${TABLE}.geo_country = 'BW' THEN 'BWA'
      # WHEN ${TABLE}.geo_country = 'BV' THEN 'BVT'
      # WHEN ${TABLE}.geo_country = 'BR' THEN 'BRA'
      # WHEN ${TABLE}.geo_country = 'IO' THEN 'IOT'
      # WHEN ${TABLE}.geo_country = 'BN' THEN 'BRN'
      # WHEN ${TABLE}.geo_country = 'BG' THEN 'BGR'
      # WHEN ${TABLE}.geo_country = 'BF' THEN 'BFA'
      # WHEN ${TABLE}.geo_country = 'BI' THEN 'BDI'
      # WHEN ${TABLE}.geo_country = 'KH' THEN 'KHM'
      # WHEN ${TABLE}.geo_country = 'CM' THEN 'CMR'
      # WHEN ${TABLE}.geo_country = 'CA' THEN 'CAN'
      # WHEN ${TABLE}.geo_country = 'CV' THEN 'CPV'
      # WHEN ${TABLE}.geo_country = 'KY' THEN 'CYM'
      # WHEN ${TABLE}.geo_country = 'CF' THEN 'CAF'
      # WHEN ${TABLE}.geo_country = 'TD' THEN 'TCD'
      # WHEN ${TABLE}.geo_country = 'CL' THEN 'CHL'
      # WHEN ${TABLE}.geo_country = 'CN' THEN 'CHN'
      # WHEN ${TABLE}.geo_country = 'CX' THEN 'CXR'
      # WHEN ${TABLE}.geo_country = 'CC' THEN 'CCK'
      # WHEN ${TABLE}.geo_country = 'CO' THEN 'COL'
      # WHEN ${TABLE}.geo_country = 'KM' THEN 'COM'
      # WHEN ${TABLE}.geo_country = 'CG' THEN 'COG'
      # WHEN ${TABLE}.geo_country = 'CD' THEN 'COD'
      # WHEN ${TABLE}.geo_country = 'CK' THEN 'COK'
      # WHEN ${TABLE}.geo_country = 'CR' THEN 'CRI'
      # WHEN ${TABLE}.geo_country = 'CI' THEN 'CIV'
      # WHEN ${TABLE}.geo_country = 'HR' THEN 'HRV'
      # WHEN ${TABLE}.geo_country = 'CU' THEN 'CUB'
      # WHEN ${TABLE}.geo_country = 'CW' THEN 'CUW'
      # WHEN ${TABLE}.geo_country = 'CY' THEN 'CYP'
      # WHEN ${TABLE}.geo_country = 'CZ' THEN 'CZE'
      # WHEN ${TABLE}.geo_country = 'DK' THEN 'DNK'
      # WHEN ${TABLE}.geo_country = 'DJ' THEN 'DJI'
      # WHEN ${TABLE}.geo_country = 'DM' THEN 'DMA'
      # WHEN ${TABLE}.geo_country = 'DO' THEN 'DOM'
      # WHEN ${TABLE}.geo_country = 'EC' THEN 'ECU'
      # WHEN ${TABLE}.geo_country = 'EG' THEN 'EGY'
      # WHEN ${TABLE}.geo_country = 'SV' THEN 'SLV'
      # WHEN ${TABLE}.geo_country = 'GQ' THEN 'GNQ'
      # WHEN ${TABLE}.geo_country = 'ER' THEN 'ERI'
      # WHEN ${TABLE}.geo_country = 'EE' THEN 'EST'
      # WHEN ${TABLE}.geo_country = 'ET' THEN 'ETH'
      # WHEN ${TABLE}.geo_country = 'FK' THEN 'FLK'
      # WHEN ${TABLE}.geo_country = 'FO' THEN 'FRO'
      # WHEN ${TABLE}.geo_country = 'FJ' THEN 'FJI'
      # WHEN ${TABLE}.geo_country = 'FI' THEN 'FIN'
      # WHEN ${TABLE}.geo_country = 'FR' THEN 'FRA'
      # WHEN ${TABLE}.geo_country = 'GF' THEN 'GUF'
      # WHEN ${TABLE}.geo_country = 'PF' THEN 'PYF'
      # WHEN ${TABLE}.geo_country = 'TF' THEN 'ATF'
      # WHEN ${TABLE}.geo_country = 'GA' THEN 'GAB'
      # WHEN ${TABLE}.geo_country = 'GM' THEN 'GMB'
      # WHEN ${TABLE}.geo_country = 'GE' THEN 'GEO'
      # WHEN ${TABLE}.geo_country = 'DE' THEN 'DEU'
      # WHEN ${TABLE}.geo_country = 'GH' THEN 'GHA'
      # WHEN ${TABLE}.geo_country = 'GI' THEN 'GIB'
      # WHEN ${TABLE}.geo_country = 'GR' THEN 'GRC'
      # WHEN ${TABLE}.geo_country = 'GL' THEN 'GRL'
      # WHEN ${TABLE}.geo_country = 'GD' THEN 'GRD'
      # WHEN ${TABLE}.geo_country = 'GP' THEN 'GLP'
      # WHEN ${TABLE}.geo_country = 'GU' THEN 'GUM'
      # WHEN ${TABLE}.geo_country = 'GT' THEN 'GTM'
      # WHEN ${TABLE}.geo_country = 'GG' THEN 'GGY'
      # WHEN ${TABLE}.geo_country = 'GN' THEN 'GIN'
      # WHEN ${TABLE}.geo_country = 'GW' THEN 'GNB'
      # WHEN ${TABLE}.geo_country = 'GY' THEN 'GUY'
      # WHEN ${TABLE}.geo_country = 'HT' THEN 'HTI'
      # WHEN ${TABLE}.geo_country = 'HM' THEN 'HMD'
      # WHEN ${TABLE}.geo_country = 'VA' THEN 'VAT'
      # WHEN ${TABLE}.geo_country = 'HN' THEN 'HND'
      # WHEN ${TABLE}.geo_country = 'HK' THEN 'HKG'
      # WHEN ${TABLE}.geo_country = 'HU' THEN 'HUN'
      # WHEN ${TABLE}.geo_country = 'IS' THEN 'ISL'
      # WHEN ${TABLE}.geo_country = 'IN' THEN 'IND'
      # WHEN ${TABLE}.geo_country = 'ID' THEN 'IDN'
      # WHEN ${TABLE}.geo_country = 'IR' THEN 'IRN'
      # WHEN ${TABLE}.geo_country = 'IQ' THEN 'IRQ'
      # WHEN ${TABLE}.geo_country = 'IE' THEN 'IRL'
      # WHEN ${TABLE}.geo_country = 'IM' THEN 'IMN'
      # WHEN ${TABLE}.geo_country = 'IL' THEN 'ISR'
      # WHEN ${TABLE}.geo_country = 'IT' THEN 'ITA'
      # WHEN ${TABLE}.geo_country = 'JM' THEN 'JAM'
      # WHEN ${TABLE}.geo_country = 'JP' THEN 'JPN'
      # WHEN ${TABLE}.geo_country = 'JE' THEN 'JEY'
      # WHEN ${TABLE}.geo_country = 'JO' THEN 'JOR'
      # WHEN ${TABLE}.geo_country = 'KZ' THEN 'KAZ'
      # WHEN ${TABLE}.geo_country = 'KE' THEN 'KEN'
      # WHEN ${TABLE}.geo_country = 'KI' THEN 'KIR'
      # WHEN ${TABLE}.geo_country = 'KP' THEN 'PRK'
      # WHEN ${TABLE}.geo_country = 'KR' THEN 'KOR'
      # WHEN ${TABLE}.geo_country = 'KW' THEN 'KWT'
      # WHEN ${TABLE}.geo_country = 'KG' THEN 'KGZ'
      # WHEN ${TABLE}.geo_country = 'LA' THEN 'LAO'
      # WHEN ${TABLE}.geo_country = 'LV' THEN 'LVA'
      # WHEN ${TABLE}.geo_country = 'LB' THEN 'LBN'
      # WHEN ${TABLE}.geo_country = 'LS' THEN 'LSO'
      # WHEN ${TABLE}.geo_country = 'LR' THEN 'LBR'
      # WHEN ${TABLE}.geo_country = 'LY' THEN 'LBY'
      # WHEN ${TABLE}.geo_country = 'LI' THEN 'LIE'
      # WHEN ${TABLE}.geo_country = 'LT' THEN 'LTU'
      # WHEN ${TABLE}.geo_country = 'LU' THEN 'LUX'
      # WHEN ${TABLE}.geo_country = 'MO' THEN 'MAC'
      # WHEN ${TABLE}.geo_country = 'MK' THEN 'MKD'
      # WHEN ${TABLE}.geo_country = 'MG' THEN 'MDG'
      # WHEN ${TABLE}.geo_country = 'MW' THEN 'MWI'
      # WHEN ${TABLE}.geo_country = 'MY' THEN 'MYS'
      # WHEN ${TABLE}.geo_country = 'MV' THEN 'MDV'
      # WHEN ${TABLE}.geo_country = 'ML' THEN 'MLI'
      # WHEN ${TABLE}.geo_country = 'MT' THEN 'MLT'
      # WHEN ${TABLE}.geo_country = 'MH' THEN 'MHL'
      # WHEN ${TABLE}.geo_country = 'MQ' THEN 'MTQ'
      # WHEN ${TABLE}.geo_country = 'MR' THEN 'MRT'
      # WHEN ${TABLE}.geo_country = 'MU' THEN 'MUS'
      # WHEN ${TABLE}.geo_country = 'YT' THEN 'MYT'
      # WHEN ${TABLE}.geo_country = 'MX' THEN 'MEX'
      # WHEN ${TABLE}.geo_country = 'FM' THEN 'FSM'
      # WHEN ${TABLE}.geo_country = 'MD' THEN 'MDA'
      # WHEN ${TABLE}.geo_country = 'MC' THEN 'MCO'
      # WHEN ${TABLE}.geo_country = 'MN' THEN 'MNG'
      # WHEN ${TABLE}.geo_country = 'ME' THEN 'MNE'
      # WHEN ${TABLE}.geo_country = 'MS' THEN 'MSR'
      # WHEN ${TABLE}.geo_country = 'MA' THEN 'MAR'
      # WHEN ${TABLE}.geo_country = 'MZ' THEN 'MOZ'
      # WHEN ${TABLE}.geo_country = 'MM' THEN 'MMR'
      # WHEN ${TABLE}.geo_country = 'NA' THEN 'NAM'
      # WHEN ${TABLE}.geo_country = 'NR' THEN 'NRU'
      # WHEN ${TABLE}.geo_country = 'NP' THEN 'NPL'
      # WHEN ${TABLE}.geo_country = 'NL' THEN 'NLD'
      # WHEN ${TABLE}.geo_country = 'NC' THEN 'NCL'
      # WHEN ${TABLE}.geo_country = 'NZ' THEN 'NZL'
      # WHEN ${TABLE}.geo_country = 'NI' THEN 'NIC'
      # WHEN ${TABLE}.geo_country = 'NE' THEN 'NER'
      # WHEN ${TABLE}.geo_country = 'NG' THEN 'NGA'
      # WHEN ${TABLE}.geo_country = 'NU' THEN 'NIU'
      # WHEN ${TABLE}.geo_country = 'NF' THEN 'NFK'
      # WHEN ${TABLE}.geo_country = 'MP' THEN 'MNP'
      # WHEN ${TABLE}.geo_country = 'NO' THEN 'NOR'
      # WHEN ${TABLE}.geo_country = 'OM' THEN 'OMN'
      # WHEN ${TABLE}.geo_country = 'PK' THEN 'PAK'
      # WHEN ${TABLE}.geo_country = 'PW' THEN 'PLW'
      # WHEN ${TABLE}.geo_country = 'PS' THEN 'PSE'
      # WHEN ${TABLE}.geo_country = 'PA' THEN 'PAN'
      # WHEN ${TABLE}.geo_country = 'PG' THEN 'PNG'
      # WHEN ${TABLE}.geo_country = 'PY' THEN 'PRY'
      # WHEN ${TABLE}.geo_country = 'PE' THEN 'PER'
      # WHEN ${TABLE}.geo_country = 'PH' THEN 'PHL'
      # WHEN ${TABLE}.geo_country = 'PN' THEN 'PCN'
      # WHEN ${TABLE}.geo_country = 'PL' THEN 'POL'
      # WHEN ${TABLE}.geo_country = 'PT' THEN 'PRT'
      # WHEN ${TABLE}.geo_country = 'PR' THEN 'PRI'
      # WHEN ${TABLE}.geo_country = 'QA' THEN 'QAT'
      # WHEN ${TABLE}.geo_country = 'RE' THEN 'REU'
      # WHEN ${TABLE}.geo_country = 'RO' THEN 'ROU'
      # WHEN ${TABLE}.geo_country = 'RU' THEN 'RUS'
      # WHEN ${TABLE}.geo_country = 'RW' THEN 'RWA'
      # WHEN ${TABLE}.geo_country = 'BL' THEN 'BLM'
      # WHEN ${TABLE}.geo_country = 'SH' THEN 'SHN'
      # WHEN ${TABLE}.geo_country = 'KN' THEN 'KNA'
      # WHEN ${TABLE}.geo_country = 'LC' THEN 'LCA'
      # WHEN ${TABLE}.geo_country = 'MF' THEN 'MAF'
      # WHEN ${TABLE}.geo_country = 'PM' THEN 'SPM'
      # WHEN ${TABLE}.geo_country = 'VC' THEN 'VCT'
      # WHEN ${TABLE}.geo_country = 'WS' THEN 'WSM'
      # WHEN ${TABLE}.geo_country = 'SM' THEN 'SMR'
      # WHEN ${TABLE}.geo_country = 'ST' THEN 'STP'
      # WHEN ${TABLE}.geo_country = 'SA' THEN 'SAU'
      # WHEN ${TABLE}.geo_country = 'SN' THEN 'SEN'
      # WHEN ${TABLE}.geo_country = 'RS' THEN 'SRB'
      # WHEN ${TABLE}.geo_country = 'SC' THEN 'SYC'
      # WHEN ${TABLE}.geo_country = 'SL' THEN 'SLE'
      # WHEN ${TABLE}.geo_country = 'SG' THEN 'SGP'
      # WHEN ${TABLE}.geo_country = 'SX' THEN 'SXM'
      # WHEN ${TABLE}.geo_country = 'SK' THEN 'SVK'
      # WHEN ${TABLE}.geo_country = 'SI' THEN 'SVN'
      # WHEN ${TABLE}.geo_country = 'SB' THEN 'SLB'
      # WHEN ${TABLE}.geo_country = 'SO' THEN 'SOM'
      # WHEN ${TABLE}.geo_country = 'ZA' THEN 'ZAF'
      # WHEN ${TABLE}.geo_country = 'GS' THEN 'SGS'
      # WHEN ${TABLE}.geo_country = 'SS' THEN 'SSD'
      # WHEN ${TABLE}.geo_country = 'ES' THEN 'ESP'
      # WHEN ${TABLE}.geo_country = 'LK' THEN 'LKA'
      # WHEN ${TABLE}.geo_country = 'SD' THEN 'SDN'
      # WHEN ${TABLE}.geo_country = 'SR' THEN 'SUR'
      # WHEN ${TABLE}.geo_country = 'SJ' THEN 'SJM'
      # WHEN ${TABLE}.geo_country = 'SZ' THEN 'SWZ'
      # WHEN ${TABLE}.geo_country = 'SE' THEN 'SWE'
      # WHEN ${TABLE}.geo_country = 'CH' THEN 'CHE'
      # WHEN ${TABLE}.geo_country = 'SY' THEN 'SYR'
      # WHEN ${TABLE}.geo_country = 'TW' THEN 'TWN'
      # WHEN ${TABLE}.geo_country = 'TJ' THEN 'TJK'
      # WHEN ${TABLE}.geo_country = 'TZ' THEN 'TZA'
      # WHEN ${TABLE}.geo_country = 'TH' THEN 'THA'
      # WHEN ${TABLE}.geo_country = 'TL' THEN 'TLS'
      # WHEN ${TABLE}.geo_country = 'TG' THEN 'TGO'
      # WHEN ${TABLE}.geo_country = 'TK' THEN 'TKL'
      # WHEN ${TABLE}.geo_country = 'TO' THEN 'TON'
      # WHEN ${TABLE}.geo_country = 'TT' THEN 'TTO'
      # WHEN ${TABLE}.geo_country = 'TN' THEN 'TUN'
      # WHEN ${TABLE}.geo_country = 'TR' THEN 'TUR'
      # WHEN ${TABLE}.geo_country = 'TM' THEN 'TKM'
      # WHEN ${TABLE}.geo_country = 'TC' THEN 'TCA'
      # WHEN ${TABLE}.geo_country = 'TV' THEN 'TUV'
      # WHEN ${TABLE}.geo_country = 'UG' THEN 'UGA'
      # WHEN ${TABLE}.geo_country = 'UA' THEN 'UKR'
      # WHEN ${TABLE}.geo_country = 'AE' THEN 'ARE'
      # WHEN ${TABLE}.geo_country = 'GB' THEN 'GBR'
      # WHEN ${TABLE}.geo_country = 'US' THEN 'USA'
      # WHEN ${TABLE}.geo_country = 'UM' THEN 'UMI'
      # WHEN ${TABLE}.geo_country = 'UY' THEN 'URY'
      # WHEN ${TABLE}.geo_country = 'UZ' THEN 'UZB'
      # WHEN ${TABLE}.geo_country = 'VU' THEN 'VUT'
      # WHEN ${TABLE}.geo_country = 'VE' THEN 'VEN'
      # WHEN ${TABLE}.geo_country = 'VN' THEN 'VNM'
      # WHEN ${TABLE}.geo_country = 'VG' THEN 'VGB'
      # WHEN ${TABLE}.geo_country = 'VI' THEN 'VIR'
      # WHEN ${TABLE}.geo_country = 'WF' THEN 'WLF'
      # WHEN ${TABLE}.geo_country = 'EH' THEN 'ESH'
      # WHEN ${TABLE}.geo_country = 'YE' THEN 'YEM'
      # WHEN ${TABLE}.geo_country = 'ZM' THEN 'ZMB'
      # WHEN ${TABLE}.geo_country = 'ZW' THEN 'ZWE'
      # ELSE NULL
      # END;;
  }

  dimension: testing_flags_api {
    sql: CASE WHEN random() < 2 THEN 'fra' ELSE NULL END ;;
    html: <img src="https://restcountries.eu/data/{{ value }}.svg" style="width:50px;height:30px;"/> ;;
  }

  dimension: plotting_ip_addresses {
    type: string
    sql: '144.2.243.170' ;;
    html: <img src="http://freegeoip.net/json/{{ value }}"/> ;;
  }

  measure: pie_chartspree {
    group_label: "ChartSpree"
    type:  number
    sql: AVG(${sepal_length})*100 / MAX(${sepal_length}) ;;
  html: <img src="//chartspree.io/pie.svg?Some=1&Thing=2"/> ;;
  }

  measure: bar_chartspree {
    group_label: "ChartSpree"
    type:  number
    sql: AVG(${sepal_length})*100 / MAX(${sepal_length}) ;;
    html: <img src="//chartspree.io/pie.svg?Some=1&Thing=2"/> ;;
  }

  measure: line_chartspree {
    group_label: "ChartSpree"
    type:  number
    sql: AVG(${sepal_length})*100 / MAX(${sepal_length}) ;;
    html: <img src="http://chartspree.io/line.svg?Foo=lorem_hockey&_show_legend=false&_height=300px&_interpolate=cubic&_fill=true"> ;;
}
}
