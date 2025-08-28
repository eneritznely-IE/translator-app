defmodule Translator.FakeHttpClient do
  @moduledoc """
    Fake HTTP client for tests.
    Simulates responses from DeepL API without making real HTTP calls.
  """

  defmodule Response do
    defstruct status_code: nil, body: nil
  end

  # Simulate a successful translation
  def post(_url, _body, _headers, _opts \\ []) do
    {:ok,
     %Response{
       status_code: 200,
       body: ~s({"translations":[{"text":"Hola mundo"}]})
     }}
  end
end
