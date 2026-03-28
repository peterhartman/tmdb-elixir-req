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

  describe "top_rated/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/top_rated", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 10, "total_results": 200})
        )
      end)

      result = TmdbElixirReq.Movies.top_rated()

      assert result["page"] == 1
      assert result["total_pages"] == 10
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/top_rated", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"
        Plug.Conn.resp(conn, 200, ~s({"page": 2, "results": []}))
      end)

      TmdbElixirReq.Movies.top_rated(%{page: 2})
    end
  end

  describe "upcoming/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/upcoming", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 3, "total_results": 50})
        )
      end)

      result = TmdbElixirReq.Movies.upcoming()

      assert result["page"] == 1
      assert result["total_pages"] == 3
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/upcoming", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      TmdbElixirReq.Movies.upcoming(%{language: "en-US"})
    end
  end

  describe "now_playing/1" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/now_playing", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 2, "total_results": 30})
        )
      end)

      result = TmdbElixirReq.Movies.now_playing()

      assert result["page"] == 1
      assert result["total_pages"] == 2
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/now_playing", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["region"] == "US"
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      TmdbElixirReq.Movies.now_playing(%{region: "US"})
    end
  end

  describe "credits/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/credits", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "cast": [], "crew": []}))
      end)

      result = TmdbElixirReq.Movies.credits(11836)

      assert result["id"] == 11836
      assert result["cast"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/credits", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 11836}))
      end)

      TmdbElixirReq.Movies.credits(11836, %{language: "en-US"})
    end
  end

  describe "reviews/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/reviews", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"id": 11836, "page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Movies.reviews(11836)

      assert result["id"] == 11836
      assert result["page"] == 1
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/reviews", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "page": 2}))
      end)

      TmdbElixirReq.Movies.reviews(11836, %{page: 2})
    end
  end

  describe "recommendations/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/recommendations", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Movies.recommendations(11836)

      assert result["page"] == 1
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/recommendations", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["page"] == "2"
        Plug.Conn.resp(conn, 200, ~s({"page": 2, "results": []}))
      end)

      TmdbElixirReq.Movies.recommendations(11836, %{page: 2})
    end
  end

  describe "similar/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/similar", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s({"page": 1, "results": [], "total_pages": 1, "total_results": 0})
        )
      end)

      result = TmdbElixirReq.Movies.similar(11836)

      assert result["page"] == 1
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/similar", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"page": 1, "results": []}))
      end)

      TmdbElixirReq.Movies.similar(11836, %{language: "en-US"})
    end
  end

  describe "videos/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/videos", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "results": []}))
      end)

      result = TmdbElixirReq.Movies.videos(11836)

      assert result["id"] == 11836
      assert result["results"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/videos", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en-US"
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "results": []}))
      end)

      TmdbElixirReq.Movies.videos(11836, %{language: "en-US"})
    end
  end

  describe "keywords/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/keywords", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "keywords": []}))
      end)

      result = TmdbElixirReq.Movies.keywords(11836)

      assert result["id"] == 11836
      assert result["keywords"] == []
    end
  end

  describe "images/2" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/images", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"id": 11836, "backdrops": [], "posters": []}))
      end)

      result = TmdbElixirReq.Movies.images(11836)

      assert result["id"] == 11836
      assert result["backdrops"] == []
    end

    test "encodes additional params in the query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/movie/11836/images", fn conn ->
        params = URI.decode_query(conn.query_string)
        assert params["language"] == "en"
        Plug.Conn.resp(conn, 200, ~s({"id": 11836}))
      end)

      TmdbElixirReq.Movies.images(11836, %{language: "en"})
    end
  end
end
