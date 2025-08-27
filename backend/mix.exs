defmodule Translator.MixProject do
  use Mix.Project

  def project do
    [
      app: :translator,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {Translator.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:httpoison, "~> 1.8"},
      {:cors_plug, "~> 3.0"},
      {:dotenv_parser, "~> 2.0"}
    ]
  end
end
