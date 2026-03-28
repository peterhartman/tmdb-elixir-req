# TMDb Elixir

An Elixir library for the TMDb API based on `tmdb_elixir`

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
Set `TMDB_READ_ACCESS_TOKEN` in your environment before using the library.

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
