defmodule TmdbElixirReq.Movies do
  @moduledoc """
  Used for making calls related to movies.
  """

  alias TmdbElixirReq.Base

  @doc """
  Get the top level details of a movie by ID.

  Returns a map with data for the corresponding movie.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-details) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.find(11836)["title"]
      "The SpongeBob SquarePants Movie"
  """
  def find(id, params \\ %{}) do
    Base.get!("movie/#{id}?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of movies ordered by popularity.

  Returns a map with a paginated list of popular movies.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-popular-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.popular()["page"]
      1
  """
  @doc since: "0.1.0"
  def popular(params \\ %{}) do
    Base.get!("movie/popular?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of movies ordered by rating.

  Returns a map with a paginated list of top-rated movies.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-top-rated-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.top_rated()["page"]
      1
  """
  def top_rated(params \\ %{}) do
    Base.get!("movie/top_rated?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of movies that are being released soon.

  Returns a map with a paginated list of upcoming movies.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-upcoming-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.upcoming()["page"]
      1
  """
  def upcoming(params \\ %{}) do
    Base.get!("movie/upcoming?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of movies that are currently in theatres.

  Returns a map with a paginated list of now-playing movies.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-now-playing-list) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.now_playing()["page"]
      1
  """
  def now_playing(params \\ %{}) do
    Base.get!("movie/now_playing?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the cast and crew for a movie.

  Returns a map with cast and crew lists for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-credits) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.credits(11836)["id"]
      11836
  """
  def credits(id, params \\ %{}) do
    Base.get!("movie/#{id}/credits?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the user reviews for a movie.

  Returns a map with a paginated list of reviews for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-reviews) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.reviews(11836)["id"]
      11836
  """
  def reviews(id, params \\ %{}) do
    Base.get!("movie/#{id}/reviews?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of recommended movies for a movie.

  Returns a map with a paginated list of recommended movies for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-recommendations) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.recommendations(11836)["page"]
      1
  """
  def recommendations(id, params \\ %{}) do
    Base.get!("movie/#{id}/recommendations?#{URI.encode_query(params)}").body
  end

  @doc """
  Get a list of movies similar to a given movie.

  Returns a map with a paginated list of similar movies for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-similar) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.similar(11836)["page"]
      1
  """
  def similar(id, params \\ %{}) do
    Base.get!("movie/#{id}/similar?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the videos that have been added to a movie.

  Returns a map with a list of video results (trailers, teasers, clips, etc.) for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-videos) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.videos(11836)["id"]
      11836
  """
  def videos(id, params \\ %{}) do
    Base.get!("movie/#{id}/videos?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the keywords that have been added to a movie.

  Returns a map with the keywords for the given movie ID.

  See [TMDb Docs](https://developer.themoviedb.org/reference/movie-keywords) for more info.

  ## Examples

      iex> TmdbElixirReq.Movies.keywords(11836)["id"]
      11836
  """
  def keywords(id, params \\ %{}) do
    Base.get!("movie/#{id}/keywords?#{URI.encode_query(params)}").body
  end

  @doc """
  Get the images that belong to a movie.

  Returns a map with backdrops, logos, and posters for the given movie ID.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/movie-images) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.Movies.images(11836)["id"]
      11836
  """
  def images(id, params \\ %{}) do
    Base.get!("movie/#{id}/images?#{URI.encode_query(params)}").body
  end
end
