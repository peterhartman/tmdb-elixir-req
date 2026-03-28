# TMDb Elixir Req

An Elixir library for the [TMDb](https://www.themoviedb.org/) API based on `tmdb_elixir` which uses Req instead of HTTPoison

## Installation

Add `tmdb_elixir_req` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tmdb_elixir_req, "~> 0.1.0"}
  ]
end
```

## Configuration

Set `auth_token` in your `config.exs` using a [TMDb Read Access Token](https://developer.themoviedb.org/docs/authentication):

```elixir
config :tmdb_elixir_req,
  auth_token: System.get_env("TMDB_READ_ACCESS_TOKEN")
```

## Usage

### Movies

```elixir
# Get movie details by ID
TmdbElixirReq.Movies.find(11836)
#=> %{"id" => 11836, "title" => "The SpongeBob SquarePants Movie", ...}

# Popular, top-rated, upcoming, and now-playing lists
TmdbElixirReq.Movies.popular()
TmdbElixirReq.Movies.top_rated()
TmdbElixirReq.Movies.upcoming()
TmdbElixirReq.Movies.now_playing()

# Paginate and filter with params
TmdbElixirReq.Movies.popular(%{page: 2, language: "en-US"})

# Credits, reviews, recommendations, similar movies
TmdbElixirReq.Movies.credits(11836)
#=> %{"id" => 11836, "cast" => [...], "crew" => [...]}

TmdbElixirReq.Movies.reviews(11836)
TmdbElixirReq.Movies.recommendations(11836)
TmdbElixirReq.Movies.similar(11836)

# Videos (trailers, teasers, clips)
TmdbElixirReq.Movies.videos(11836)
#=> %{"id" => 11836, "results" => [%{"type" => "Trailer", "site" => "YouTube", ...}]}

# Keywords and images
TmdbElixirReq.Movies.keywords(11836)
TmdbElixirReq.Movies.images(11836)
```

### TV Series

```elixir
# Get TV series details by ID
TmdbElixirReq.TV.find(1396)
#=> %{"id" => 1396, "name" => "Breaking Bad", ...}

# Popular and top-rated lists
TmdbElixirReq.TV.popular()
TmdbElixirReq.TV.top_rated(%{page: 2})

# Credits and season details
TmdbElixirReq.TV.credits(1396)
#=> %{"id" => 1396, "cast" => [...], "crew" => [...]}

TmdbElixirReq.TV.season(1396, 1)
#=> %{"season_number" => 1, "episodes" => [...]}
```

### People

```elixir
# Get person details by ID
TmdbElixirReq.People.find(287)
#=> %{"id" => 287, "name" => "Brad Pitt", ...}

# Popular people list
TmdbElixirReq.People.popular()

# Movie, TV, and combined credits
TmdbElixirReq.People.movie_credits(287)
#=> %{"id" => 287, "cast" => [...], "crew" => [...]}

TmdbElixirReq.People.tv_credits(287)
TmdbElixirReq.People.combined_credits(287)

# Profile images and external IDs (IMDB, social media, etc.)
TmdbElixirReq.People.images(287)
TmdbElixirReq.People.external_ids(287)
#=> %{"id" => 287, "imdb_id" => "nm0000093", ...}
```

### Search

```elixir
# Search for movies, TV shows, and people
TmdbElixirReq.Search.movies("spongebob")
TmdbElixirReq.Search.tv("breaking bad")
TmdbElixirReq.Search.people("brad pitt")

# Search across all media types at once
TmdbElixirReq.Search.multi("spongebob")

# Paginate and filter results
TmdbElixirReq.Search.movies("spongebob", %{page: 2, language: "en-US"})
```

### Trending

```elixir
# Get trending content by media type and time window
# media_type: "movie" | "tv" | "person" | "all"
# time_window: "day" | "week"
TmdbElixirReq.Trending.trending("movie", "day")
TmdbElixirReq.Trending.trending("tv", "week")
TmdbElixirReq.Trending.trending("all", "day")
```

### Configuration

```elixir
# Fetch API configuration (image base URLs, supported sizes, etc.)
TmdbElixirReq.Configuration.configuration()
#=> %{"images" => %{"base_url" => "http://image.tmdb.org/t/p/", ...}}
```
