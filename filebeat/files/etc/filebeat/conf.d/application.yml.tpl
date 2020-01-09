- input_type: log
  paths:
    - {{ ProjectDir }}/qdata/logs/geth.log
  fields:
    SERVICE: "quorum-nodes"
    MODULE: "geth"
    LOG_TYPE: "geth"
  fields_under_root: true

- input_type: log
  paths:
    - {{ ProjectDir }}/qdata/logs/tessera.log
  fields:
    SERVICE: "quorum-nodes"
    MODULE: "privacy-impl"
    LOG_TYPE: "tessera"
  fields_under_root: true

- input_type: log
  paths:
    - {{ ProjectDir }}/qdata/logs/constellation.log
  fields:
    SERVICE: "quorum-nodes"
    MODULE: "privacy-impl"
    LOG_TYPE: "constellation"
  fields_under_root: true
