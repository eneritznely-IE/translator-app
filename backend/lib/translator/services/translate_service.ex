defmodule Translator.Services.TranslateService do
  @moduledoc """
  Service for calling the DeepL Free API to perform text translation.
  """
  # DeepL Free API endpoint
  @deepl_url "https://api-free.deepl.com/v2/translate"
  @http_client Application.compile_env(:translator, :http_client, Translator.RealHttpClient)

  @doc """
    Translates `text` to `target_lang` using the provided HTTP client.
    Defaults to `Translator.RealHTTPClient` for production.
    Returns `{:ok, data}` on success or `{:error, reason}` on failure.
  """
  def translate(text, target_lang) do
    key = System.get_env("DEEPL_API_KEY")
    with key when key not in [nil, ""] <- key, # Get API key from environment
         body <- URI.encode_query(%{"auth_key" => key, "text" => text, "target_lang" => target_lang}), # Encode request body
         headers <- [{"Content-Type", "application/x-www-form-urlencoded"}], # Set request headers
         {:ok, %{status_code: 200, body: resp_body}} <- @http_client.post(@deepl_url, body, headers, []), # Send POST request
         {:ok, data} <- Jason.decode(resp_body) # Decode JSON response
    do
      {:ok, data} # Return parsed data
    else
      nil -> {:error, "DEEPL_API_KEY not set"}  # API key missing
      {:ok, %{status_code: code, body: body}} -> {:error, "DeepL error #{code}: #{body}"} # API error response
      {:error, reason} -> {:error, inspect(reason)} # HTTPoison or JSON decode error
      _ -> {:error, "Invalid response from DeepL"} # Catch-all fallback
    end
  end
end
