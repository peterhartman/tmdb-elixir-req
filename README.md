# TMDb Elixir Req

An Elixir library for the TMDb API based on `tmdb_elixir` which uses Req instead of HTTPoison

[Docs]

## Installation

Add `tmdb_elixir_req` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tmdb_elixir_req, "~> 0.1.0"}
  ]
end
```

## Usage

### Access token
Set `auth_token` in your `config.exs`
```
config :tmdb_elixir_req,
  auth_token: System.get_env("TMDB_READ_ACCESS_TOKEN")
```

### Searching for movies or people:

```elixir
TmdbElixirReq.Search.movies("spongebob")

TmdbElixirReq.Search.people("brad pitt")
```

### Finding by id:

```elixir
TmdbElixirReq.Movies.find(11836)

TmdbElixirReq.People.find(287)
```
