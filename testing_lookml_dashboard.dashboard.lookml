- dashboard: testing_lookml_dashboard
  title: Testing Lookml Dashboard
  layout: tile
  tile_size: 100

  filters:
    - name: order_date
      type: field_filter
      explore: sub_trip
      field: sub_trip.bike_id

  elements:
    - name: add_a_unique_name_1499162142
      label: Not Showing Up Anywhere
      not: ok
      unknown: parameter
      title: Untitled Visualization
      model: model1
      explore: sub_trip
      type: single_value
      fields: [sub_trip.product_image]
      sorts: [sub_trip.product_image]
      limit: 500
      column_limit: 50
      query_timezone: America/Los_Angeles
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      show_view_names: false
      show_row_numbers: false
      truncate_column_names: true
      hide_totals: false
      hide_row_totals: false
      table_theme: transparent
      limit_displayed_rows: false
      enable_conditional_formatting: false
      conditional_formatting_ignored_fields: []
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}
      series_labels:
        sub_trip.product_image: News Report
      conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
          font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
              "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false}]
