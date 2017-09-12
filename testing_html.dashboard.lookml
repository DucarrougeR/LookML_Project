dashboard: testing_html
title: testing_html
layout: tile
tile_size: 100

elements:
- name: hello_world
model: Herbalife
explore: data
type: looker_column
fields:
- measure: revenue
type: count
html: <a target="new" href="http://www.google.com">Click for detailed view</a>
