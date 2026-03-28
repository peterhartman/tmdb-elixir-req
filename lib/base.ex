defmodule TmdbElixirReq.Base do
  @moduledoc false

  use HTTPoison.Base

  def process_response_body(body), do: Jason.decode!(body)

  def process_request_url(endpoint) do
    base_url = Application.get_env(:tmdb_elixir_req, :base_url, "https://api.themoviedb.org/3/")
    "#{base_url}#{endpoint}"
  end

  def get!(url, headers \\ [], options \\ []),
    do: request!(:get, url, "", headers ++ auth_headers(), options)

  defp auth_headers,
    do: [
      {"Authorization", "Bearer #{Application.fetch_env!(:tmdb_elixir_req, :auth_token)}"},
      {"accept", "application/json"}
    ]
end
