filter {
  mutate {
    rename => { "SERVICE" => "@service" }
    rename => { "MODULE" => "@module" }
    rename => { "LOG_TYPE" => "@log_type" }
  }
}
