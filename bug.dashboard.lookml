- dashboard: 34856_incorrect_lookml_generated
  title: "34856_incorrect_lookml_generated"
  layout: newspaper
  description: "Lists documents available in the enterprise. Documents can be searched."
  elements:
  - title: just a tile
    name: just a tile
    model: i__looker
    explore: history
    type: table
    fields:
    - look.title
    - query.count
    sorts:
    - query.count desc
    limit: 500
    query_timezone: UTC
    row: 0
    col: 0
    width: 8
    height: 6
  filters:

  - name: string filter
    title: string filter
    type: string_filter
    # default_value: ''
    # model:
    # explore:
    # field:
    # listens_to_filters: []
    allow_multiple_values: true
    required: false
