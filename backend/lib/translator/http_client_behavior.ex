defmodule Translator.HttpClientBehaviour do
  @callback post(url :: String.t(), body :: String.t(), headers :: list()) ::
              {:ok, any()} | {:error, any()}
end
