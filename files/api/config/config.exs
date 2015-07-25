use Mix.Config

config :logger, :console,
  level: :info,
  format: "$message\n"

# disable lager output
config :lager,
  error_logger_redirect: false,
  handlers: []
