defmodule TmdbElixirReq.DoctestTest do
  use ExUnit.Case, async: false

  setup_all do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")

    Bypass.stub(bypass, "GET", "/movie/11836", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"title":"The SpongeBob SquarePants Movie"}))
    end)

    Bypass.stub(bypass, "GET", "/movie/popular", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/person/287", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name":"Brad Pitt"}))
    end)

    Bypass.stub(bypass, "GET", "/search/movie", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/search/person", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"page":1,"results":[],"total_pages":1,"total_results":0}))
    end)

    Bypass.stub(bypass, "GET", "/configuration", fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"images":{"base_url":"http://image.tmdb.org/t/p/"}}))
    end)

    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    :ok
  end

  doctest TmdbElixirReq.Movies
  doctest TmdbElixirReq.People
  doctest TmdbElixirReq.Search
  doctest TmdbElixirReq.Configuration
end
