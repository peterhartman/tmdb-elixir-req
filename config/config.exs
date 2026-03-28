import Config

config :tmdb_elixir_req,
  auth_token: System.get_env("TMDB_READ_ACCESS_TOKEN")

import_config "#{config_env()}.exs"
