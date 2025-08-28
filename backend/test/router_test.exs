defmodule Translator.RouterTest do
  use ExUnit.Case, async: true
  import Plug.Test
  import Plug.Conn

  alias Translator.Router

  # Initialize router options
  @opts Router.init([])

  setup do
    # Use fake HTTP client for tests to avoid real API calls
    Application.put_env(:translator, :http_client, Translator.FakeHttpClient);
    # Set a temporary API key so TranslateService does not fail
    System.put_env("DEEPL_API_KEY", "fake-key")
    # Clean up the environment variable after each test
    on_exit(fn -> System.delete_env("DEEPL_API_KEY") end)
    :ok;
  end

  test "POST /api/translate returns translated text" do
    # Build a POST request with valid JSON payload
    conn =
      conn(:post, "/api/translate", Jason.encode!(%{"text" => "Hello world", "target_lang" => "ES"}))
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    # Check that response status is 200 OK
    assert conn.status == 200

    # Decode response and check that translation is correct
    body = Jason.decode!(conn.resp_body)
    assert hd(body["translations"])["text"] == "Hola mundo"
  end

  test "POST /api/translate with invalid payload returns 400" do
    # Build a POST request with invalid payload
    conn =
      conn(:post, "/api/translate", Jason.encode!(%{"wrong" => "data"}))
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    # Check that response status is 400 Bad Request
    assert conn.status == 400
  end
end
