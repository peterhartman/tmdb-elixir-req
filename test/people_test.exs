defmodule TmdbElixirReq.PeopleTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "find/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "name": "Brad Pitt"}))
      end)

      result = TmdbElixirReq.People.find(287)

      assert result["id"] == 287
      assert result["name"] == "Brad Pitt"
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 287}))
      end)

      TmdbElixirReq.People.find(287, %{language: "en-US"})
    end

    test "sends the Authorization bearer token header", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287", fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer test_token"]
        Plug.Conn.resp(conn, 200, ~s({}))
      end)

      TmdbElixirReq.People.find(287)
    end
  end

  describe "popular/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/popular", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 5, "total_results": 100})
        )
      end)

      result = TmdbElixirReq.People.popular()

      assert result["page"] == 1
      assert result["total_pages"] == 5
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/popular", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"
        Plug.Conn.resp(conn, 200, ~s({"page": 2, "results": []}))
      end)

      TmdbElixirReq.People.popular(%{page: 2})
    end
  end

  describe "movie_credits/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/movie_credits", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "cast": [], "crew": []}))
      end)

      result = TmdbElixirReq.People.movie_credits(287)

      assert result["id"] == 287
      assert result["cast"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/movie_credits", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 287}))
      end)

      TmdbElixirReq.People.movie_credits(287, %{language: "en-US"})
    end
  end

  describe "tv_credits/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/tv_credits", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "cast": [], "crew": []}))
      end)

      result = TmdbElixirReq.People.tv_credits(287)

      assert result["id"] == 287
      assert result["cast"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/tv_credits", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 287}))
      end)

      TmdbElixirReq.People.tv_credits(287, %{language: "en-US"})
    end
  end

  describe "combined_credits/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/combined_credits", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "cast": [], "crew": []}))
      end)

      result = TmdbElixirReq.People.combined_credits(287)

      assert result["id"] == 287
      assert result["cast"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/combined_credits", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 287}))
      end)

      TmdbElixirReq.People.combined_credits(287, %{language: "en-US"})
    end
  end

  describe "images/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/images", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "profiles": []}))
      end)

      result = TmdbElixirReq.People.images(287)

      assert result["id"] == 287
      assert result["profiles"] == []
    end
  end

  describe "external_ids/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/person/287/external_ids", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 287, "imdb_id": "nm0000093"}))
      end)

      result = TmdbElixirReq.People.external_ids(287)

      assert result["id"] == 287
      assert result["imdb_id"] == "nm0000093"
    end
  end
end
