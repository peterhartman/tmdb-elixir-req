defmodule TmdbElixirReq.MoviesTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "find/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "title": "The SpongeBob SquarePants Movie"}))
      end)

      result = TmdbElixirReq.Movies.find(11836)

      assert result["id"] == 11836
      assert result["title"] == "The SpongeBob SquarePants Movie"
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 11836}))
      end)

      TmdbElixirReq.Movies.find(11836, %{language: "en-US"})
    end

    test "sends the Authorization bearer token header", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836", fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer test_token"]
        Plug.Conn.resp(conn, 200, ~s({}))
      end)

      TmdbElixirReq.Movies.find(11836)
    end
  end

  describe "popular/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/popular", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 5, "total_results": 100})
        )
      end)

      result = TmdbElixirReq.Movies.popular()

      assert result["page"] == 1
      assert result["total_pages"] == 5
      assert result["results"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/popular", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"

        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 2, "results": [], "total_pages": 5, "total_results": 100})
        )
      end)

      TmdbElixirReq.Movies.popular(%{page: 2})
    end
  end
end
