defmodule TmdbElixir.Base do
  @moduledoc false

  use HTTPoison.Base

  def process_response_body(body), do: Poison.decode!(body)

  def process_request_url(endpoint), do: "https://api.themoviedb.org/3/#{endpoint}"

  def get!(url, headers \\ [], options \\ []),
    do: request!(:get, url, "", headers ++ auth_headers(), options)

  defp auth_headers,
    do: [
      {"Authorization", "Bearer #{Application.fetch_env!(:tmdb_elixir_req, :auth_token)}"},
      {"accept", "application/json"}
    ]
end
