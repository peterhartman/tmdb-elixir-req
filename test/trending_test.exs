defmodule TmdbElixirReq.TrendingTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "trending/3" do
    test "requests the correct path for movies/day and returns the decoded body", %{
      bypass: bypass
    } do
      Bypass.expect_once(bypass, "GET", "/trending/movie/day", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Trending.trending("movie", "day")

      assert result["page"] == 1
    end

    test "requests the correct path for tv/week", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/trending/tv/week", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 5, "total_results": 100})
        )
      end)

      result = TmdbElixirReq.Trending.trending("tv", "week")

      assert result["total_pages"] == 5
    end

    test "requests the correct path for all/day", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/trending/all/day", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      result = TmdbElixirReq.Trending.trending("all", "day")

      assert result["page"] == 1
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/trending/movie/day", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      TmdbElixirReq.Trending.trending("movie", "day", %{language: "en-US"})
    end

    test "sends the Authorization bearer token header", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/trending/movie/day", fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer test_token"]
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      TmdbElixirReq.Trending.trending("movie", "day")
    end
  end
end
