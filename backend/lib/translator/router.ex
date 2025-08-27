defmodule Translator.Router do
  use Plug.Router;
  require Logger;

  @moduledoc """
  Router.
  Handles HTTP requests and dispatches them to the appropriate service.
  """

  plug Plug.Logger; # Log each request
  plug CORSPlug, origin: "*"; # Handle CORS, allow requests from any origin
  plug :match; # Match request routes
  # Parse JSON bodies for incoming requests
  plug Plug.Parsers,
       parsers: [:json],
       json_decoder: Jason,
       pass: ["application/json", "application/json; charset=utf-8"];
  plug :dispatch; # Dispatch to matched routes

  # Handle CORS preflight requests (OPTIONS)
  match "/api/translate", via: :options do
    send_resp(conn, 204, "");
  end

  # POST /api/translate
  # Expects JSON body with "text" and "target_lang"
  # Calls TranslateService and returns the translation
  post "/api/translate" do
    with %{"text" => text, "target_lang" => target_lang} <- conn.body_params,
         {:ok, resp} <- Translator.Services.TranslateService.translate(text, target_lang)
    do
      send_resp(conn, 200, Jason.encode!(resp));
    else
      {:error, reason} -> send_resp(conn, 500, Jason.encode!(%{error: reason})); # Translation service error
      _ -> send_resp(conn, 400, Jason.encode!(%{error: "invalid payload"})); # Invalid request payload
    end
  end

  # Catch-all for unmatched routes
  match _ do
    send_resp(conn, 404, "not found");
  end
end
