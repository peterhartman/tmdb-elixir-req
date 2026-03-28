defmodule TmdbElixirReq.People do
  @moduledoc """
  Used for making calls related to people (actors and crew members).
  """

  alias TmdbElixirReq.Base

  @doc """
  Get the top level details of a person by ID.

  Returns a map with data for the corresponding person.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-details) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.find(287)["name"]
      "Brad Pitt"
  """
  def find(id, params \\ %{}) do
    Base.get!("person/#{id}?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of people ordered by popularity.

  Returns a map with a paginated list of popular people.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-popular-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.popular()["page"]
      1
  """
  def popular(params \\ %{}) do
    Base.get!("person/popular?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the movie credits for a person.

  Returns a map with cast and crew movie credits for the given person ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-movie-credits) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.movie_credits(287)["id"]
      287
  """
  def movie_credits(id, params \\ %{}) do
    Base.get!("person/#{id}/movie_credits?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the TV credits for a person.

  Returns a map with cast and crew TV credits for the given person ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-tv-credits) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.tv_credits(287)["id"]
      287
  """
  def tv_credits(id, params \\ %{}) do
    Base.get!("person/#{id}/tv_credits?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the combined movie and TV credits for a person.

  Returns a map with combined cast and crew credits for the given person ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-combined-credits) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.combined_credits(287)["id"]
      287
  """
  def combined_credits(id, params \\ %{}) do
    Base.get!("person/#{id}/combined_credits?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the profile images for a person.

  Returns a map with a list of profile images for the given person ID.

  See [TMDb Docs](https://developer.themoviedb.org/reference/person-images) for more info.

  ## Examples

      iex> TmdbElixirReq.People.images(287)["id"]
      287
  """
  def images(id, params \\ %{}) do
    Base.get!("person/#{id}/images?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the external IDs for a person.

  Returns a map with external IDs (IMDB, social media, etc.) for the given person ID.

  See [TMDb Docs](https://developer.themoviedb.org/reference/person-external-ids) for more info.

  ## Examples

      iex> TmdbElixirReq.People.external_ids(287)["id"]
      287
  """
  def external_ids(id, params \\ %{}) do
    Base.get!("person/#{id}/external_ids?#{URI.encode_query(params)}").body
  end
end
