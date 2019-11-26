output {
  elasticsearch {
    hosts => "https://{{ es_domain }}:443"
  }
}
