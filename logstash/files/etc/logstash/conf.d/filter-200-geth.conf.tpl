filter {
  if [@service] == "quorum-nodes" and [@module] == "geth" and [@log_type] == "geth" {
    grok {
      match => {
        "message" => [
          "%{LOGLEVEL:log_level} \[%{NOTSPACE:time}\] %{GREEDYDATA:message}"
        ]
      }
      overwrite => ["message"]
    }
  }
}
