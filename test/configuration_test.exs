defmodule TmdbElixirReq.ConfigurationTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    Application.put_env(:tmdb_elixir_req, :base_url, "http://localhost:#{bypass.port}/")
    on_exit(fn -> Application.delete_env(:tmdb_elixir_req, :base_url) end)
    {:ok, bypass: bypass}
  end

  describe "configuration/0" do
    test "requests the correct path and returns the decoded body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/configuration", fn conn ->
        Plug.Conn.resp(conn, 200, ~s({"images": {"base_url": "http://image.tmdb.org/t/p/"}}))
      end)

      result = TmdbElixirReq.Configuration.configuration()

      assert get_in(result, ["images", "base_url"]) == "http://image.tmdb.org/t/p/"
    end

    test "sends the Authorization bearer token header", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/configuration", fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer test_token"]
        Plug.Conn.resp(conn, 200, ~s({}))
      end)

      TmdbElixirReq.Configuration.configuration()
    end
  end
end
