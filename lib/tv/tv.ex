defmodule TmdbElixirReq.TV do
  @moduledoc """
  Used for making calls related to TV series.
  """

  alias TmdbElixirReq.Base

  @doc """
  Get the top level details of a TV series by ID.

  Returns a map with data for the corresponding TV series.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/tv-series-details) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.TV.find(1396)["name"]
      "Breaking Bad"
  """
  def find(id, params \\ %{}) do
    Base.get!("tv/#{id}?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of TV series ordered by popularity.

  Returns a map with a paginated list of popular TV series.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/tv-series-popular-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.TV.popular()["page"]
      1
  """
  def popular(params \\ %{}) do
    Base.get!("tv/popular?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of TV series ordered by rating.

  Returns a map with a paginated list of top-rated TV series.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/tv-series-top-rated-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.TV.top_rated()["page"]
      1
  """
  def top_rated(params \\ %{}) do
    Base.get!("tv/top_rated?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the aggregate cast and crew for a TV series.

  Returns a map with cast and crew lists for the given TV series ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/tv-series-credits) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.TV.credits(1396)["id"]
      1396
  """
  def credits(id, params \\ %{}) do
    Base.get!("tv/#{id}/credits?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the season details for a TV series.

  Returns a map with episode list and details for the given TV series ID and season number.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/tv-season-details) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.TV.season(1396, 1)["season_number"]
      1
  """
  def season(id, season_number, params \\ %{}) do
    Base.get!("tv/#{id}/season/#{season_number}?#{URI.encode_query(params)}").body
  end
end
