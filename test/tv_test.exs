defmodule TmdbElixirReq.TVTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "find/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 1396, "name": "Breaking Bad"}))
      end)

      result = TmdbElixirReq.TV.find(1396)

      assert result["id"] == 1396
      assert result["name"] == "Breaking Bad"
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 1396}))
      end)

      TmdbElixirReq.TV.find(1396, %{language: "en-US"})
    end

    test "sends the Authorization bearer token header", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396", fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer test_token"]
        Plug.Conn.resp(conn, 200, ~s({}))
      end)

      TmdbElixirReq.TV.find(1396)
    end
  end

  describe "popular/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/popular", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 5, "total_results": 100})
        )
      end)

      result = TmdbElixirReq.TV.popular()

      assert result["page"] == 1
      assert result["total_pages"] == 5
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/popular", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"
        Plug.Conn.resp(conn, 200, ~s({"page": 2, "results": []}))
      end)

      TmdbElixirReq.TV.popular(%{page: 2})
    end
  end

  describe "top_rated/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/top_rated", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 10, "total_results": 200})
        )
      end)

      result = TmdbElixirReq.TV.top_rated()

      assert result["page"] == 1
      assert result["total_pages"] == 10
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/top_rated", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "3"
        Plug.Conn.resp(conn, 200, ~s({"page": 3, "results": []}))
      end)

      TmdbElixirReq.TV.top_rated(%{page: 3})
    end
  end

  describe "credits/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396/credits", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 1396, "cast": [], "crew": []}))
      end)

      result = TmdbElixirReq.TV.credits(1396)

      assert result["id"] == 1396
      assert result["cast"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396/credits", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 1396}))
      end)

      TmdbElixirReq.TV.credits(1396, %{language: "en-US"})
    end
  end

  describe "season/3" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396/season/1", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 3572, "season_number": 1, "episodes": []}))
      end)

      result = TmdbElixirReq.TV.season(1396, 1)

      assert result["season_number"] == 1
      assert result["episodes"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/tv/1396/season/2", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"season_number": 2}))
      end)

      TmdbElixirReq.TV.season(1396, 2, %{language: "en-US"})
    end
  end
end
