defmodule TmdbElixirReq.Base do
  @moduledoc false

  @doc """
  Get data from the TMDb API using a full URL.
  ## Examples

      iex> TmdbElixirReq.Base.get!("https://api.themoviedb.org/3/tv/1396")["name"]
      "Breaking Bad"
  """
  def get!(url, headers \\ [], options \\ []) do
    response =
      Req.get!(
        base_url: Application.get_env(:tmdb_elixir_req, :base_url, "https://api.themoviedb.org/3/"),
        url: url,
        headers: headers,
        auth: {:bearer, Application.fetch_env!(:tmdb_elixir_req, :auth_token)},
        params: options
      )

    case response.body do
      body when is_binary(body) -> %{response | body: Jason.decode!(body)}
      _ -> response
    end
  end
end
