defmodule TmdbElixirReq.Configuration do
  @moduledoc """
  Used for making calls related to configuration details.
  """

  alias TmdbElixirReq.Base

  @doc """
  Get API configuration details.

  Returns a map configuration data API.

  See [TMDb Docs](https://developer.themoviedb.org/reference/configuration-details) for more info.

  ## Examples

      iex> TmdbElixirReq.Configuration.configuration()["images"]["base_url"]
      "http://image.tmdb.org/t/p/"
  """
  def configuration do
    Base.get!("configuration").body
  end
end
