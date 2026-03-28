defmodule TmdbElixirReq.SearchTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "movies/2" do
    test "requests the correct path with query param", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/search/movie", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["query"] == "spongebob"

        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Search.movies("spongebob")

      assert result["page"] == 1
    end

    test "merges additional params with the query", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/search/movie", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["query"] == "spongebob"
        assert params["page"] == "2"

        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 2, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      TmdbElixirReq.Search.movies("spongebob", %{page: 2})
    end
  end

  describe "people/2" do
    test "requests the correct path with query param", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/search/person", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["query"] == "brad pitt"

        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Search.people("brad pitt")

      assert result["page"] == 1
    end

    test "merges additional params with the query", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/search/person", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["query"] == "brad pitt"
        assert params["language"] == "en-US"

        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      TmdbElixirReq.Search.people("brad pitt", %{language: "en-US"})
    end
  end
end
