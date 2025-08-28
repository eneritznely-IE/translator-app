defmodule Translator.Services.TranslateServiceTest do
  use ExUnit.Case, async: true

  alias Translator.Services.TranslateService

  setup do
     # Set fake client and temporary API key
      Application.put_env(:translator, :http_client, Translator.FakeHttpClient)
      System.put_env("DEEPL_API_KEY", "fake-key")

      # Clean up after tests
      on_exit(fn -> System.delete_env("DEEPL_API_KEY") end)

      :ok
  end

  test "successful translation using fake client" do
    {:ok, data} = TranslateService.translate("Hello world", "ES")
    assert data["translations"] |> Enum.any?(fn t -> t["text"] == "Hola mundo" end)
  end

  test "returns error when DEEPL_API_KEY is missing" do
    System.delete_env("DEEPL_API_KEY")  # Ensure key is missing
    {:error, msg} = TranslateService.translate("Hello world", "ES")
    assert msg == "DEEPL_API_KEY not set"
  end
end
