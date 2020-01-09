filter {
  if [@service] == "quorum-nodes" and [@module] == "privacy-impl" and [@log_type] == "tessera" {
    grok {
      match => {
        "message" => [
          "%{NOTSPACE:date} %{TIME:time} \[%{NOTSPACE:process}\] %{LOGLEVEL:log_level} %{GREEDYDATA:message}"
        ]
      }
      overwrite => ["message"]
    }
  }
  if [@service] == "quorum-nodes" and [@module] == "privacy-impl" and [@log_type] == "constellation" {
    grok {
      match => {
        "message" => [
          "%{TIME:time} \[%{LOGLEVEL:log_level}\] %{GREEDYDATA:message}"
        ]
      }
      overwrite => ["message"]
    }
  }
}
