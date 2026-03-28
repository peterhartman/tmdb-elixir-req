defmodule TmdbElixirReq.Trending do
  @moduledoc """
  Used for making calls related to trending content on TMDb.
  """

  alias TmdbElixirReq.Base

  @doc """
  Get the trending movies, TV series, or people.

  `media_type` must be one of `"movie"`, `"tv"`, `"person"`, or `"all"`.

  `time_window` must be one of `"day"` or `"week"`.

  Returns a map with a paginated list of trending results.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/trending-all) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Trending.trending("movie", "day")["page"]
      1
  """
  def trending(media_type, time_window, params \\ %{}) do
    Base.get!("trending/#{media_type}/#{time_window}?#{URI.encode_query(params)}").body
  end
end
