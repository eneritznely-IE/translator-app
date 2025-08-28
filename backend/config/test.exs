import Config

# In test we use the fake client and a dummy API key
config :translator,
  http_client: Translator.FakeHttpClient,
  deepl_api_key: "test_key"
