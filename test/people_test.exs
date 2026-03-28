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
end
