defmodule Translator.Services.TranslateService do
  @moduledoc """
  Service for calling the DeepL Free API to perform text translation.
  """
  # DeepL Free API endpoint
  @deepl_url "https://api-free.deepl.com/v2/translate";

  # Receives text and target language, sends a request to DeepL API,
  # and returns {:ok, data} on success or {:error, reason} on failure.
  def translate(text, target_lang) do
    with key when key != "" <- System.get_env("DEEPL_API_KEY"), # Get API key from environment
         body <- URI.encode_query(%{"auth_key" => key, "text" => text, "target_lang" => target_lang}), # Encode request body
         headers <- [{"Content-Type", "application/x-www-form-urlencoded"}], # Set request headers
         {:ok, %HTTPoison.Response{status_code: 200, body: resp_body}} <- HTTPoison.post(@deepl_url, body, headers, []), # Send POST request
         {:ok, data} <- Jason.decode(resp_body) # Decode JSON response
    do
      {:ok, data}; # Return parsed data
    else
      nil -> {:error, "DEEPL_API_KEY not set on server"};  # API key missing
      {:ok, %HTTPoison.Response{status_code: code, body: resp_body}} -> {:error, "DeepL error #{code}: #{resp_body}"}; # API error response
      {:error, reason} -> {:error, inspect(reason)}; # HTTPoison or JSON decode error
      _ -> {:error, "Invalid response from DeepL"}; # Catch-all fallback
    end
  end
end
