defmodule Translator.RealHttpClient do
  @behaviour Translator.HttpClientBehaviour

  def post(url, body, headers, opts \\ []) do
    HTTPoison.post(url, body, headers, opts)
  end
end
