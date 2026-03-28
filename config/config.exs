import Config

config :tmdb_elixir_req,
  auth_token: System.get_env("TMDB_AUTH_TOKEN")

import_config "#{config_env()}.exs"
