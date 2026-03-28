defmodule TmdbElixirReq.DoctestTest do
  use ExUnit.Case, async: false

  setup_all do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")

    # Movies
    Bypass.stub(bypass, "GET", "/movie/11836", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"title":"The SpongeBob SquarePants Movie"}))
    end)

    Bypass.stub(bypass, "GET", "/movie/popular", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/top_rated", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/upcoming", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/now_playing", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/credits", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"cast":[],"crew":[]}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/reviews", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"page":1,"results":[]}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/recommendations", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/similar", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/videos", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"results":[]}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/keywords", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"keywords":[]}))
    end)

    Bypass.stub(bypass, "GET", "/movie/11836/images", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":11836,"backdrops":[],"posters":[]}))
    end)

    # People
    Bypass.stub(bypass, "GET", "/person/287", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"name":"Brad Pitt"}))
    end)

    Bypass.stub(bypass, "GET", "/person/popular", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/person/287/movie_credits", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"cast":[],"crew":[]}))
    end)

    Bypass.stub(bypass, "GET", "/person/287/tv_credits", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"cast":[],"crew":[]}))
    end)

    Bypass.stub(bypass, "GET", "/person/287/combined_credits", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"cast":[],"crew":[]}))
    end)

    Bypass.stub(bypass, "GET", "/person/287/images", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"profiles":[]}))
    end)

    Bypass.stub(bypass, "GET", "/person/287/external_ids", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":287,"imdb_id":"nm0000093"}))
    end)

    # Search
    Bypass.stub(bypass, "GET", "/search/movie", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/search/person", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/search/tv", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/search/multi", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    # Configuration
    Bypass.stub(bypass, "GET", "/configuration", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"images":{"base_url":"http://image.tmdb.org/t/p/"}}))
    end)

    # TV
    Bypass.stub(bypass, "GET", "/tv/1396", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":1396,"name":"Breaking Bad"}))
    end)

    Bypass.stub(bypass, "GET", "/tv/popular", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/tv/top_rated", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/tv/1396/credits", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":1396,"cast":[],"crew":[]}))
    end)

    Bypass.stub(bypass, "GET", "/tv/1396/season/1", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id":3572,"season_number":1,"episodes":[]}))
    end)

    # Trending
    Bypass.stub(bypass, "GET", "/trending/movie/day", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    :ok
  end

  doctest TmdbElixirReq.Movies
  doctest TmdbElixirReq.People
  doctest TmdbElixirReq.Search
  doctest TmdbElixirReq.Configuration
  doctest TmdbElixirReq.TV
  doctest TmdbElixirReq.Trending
  doctest TmdbElixirReq.Base
end
