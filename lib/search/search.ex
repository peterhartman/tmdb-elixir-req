defmodule TmdbElixirReq.Search do
  @moduledoc """
  Used for making calls to search within TMDb.
  """

  alias TmdbElixirReq.Base

  @doc """
  Search for movies by their original, translated and alternative titles.

  Returns a map with a paginated list of movie search results.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/search-movie) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Search.movies("spongebob")["page"]
      1
  """
  def movies(query, params \\ %{}) do
    search("movie", query, params)
  end

  @doc """
  Search for people by their name and also known as names.

  Returns a map with a paginated list of person search results.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/search-person) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Search.people("brad pitt")["page"]
      1
  """
  def people(query, params \\ %{}) do
    search("person", query, params)
  end

  defp search(endpoint, query, params) do
    params = Map.merge(params, %{query: query})
    Base.get!("search/#{endpoint}?#{URI.encode_query(params)}").body
  end
end
