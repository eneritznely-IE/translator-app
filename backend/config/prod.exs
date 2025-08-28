import Config

# Development: use real HTTP client and read API key from environment
config :translator,
  http_client: HTTPoison,
  deepl_api_key: System.get_env("DEEPL_API_KEY") || ""
