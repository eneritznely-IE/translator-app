defmodule Translator.Application do
  use Application

  @moduledoc """
  Entry point.
  Starts the HTTP server and supervises child processes.
  """

  # Invoked when the application starts.
  # Loads environment variables, sets the port, and starts the Cowboy HTTP server
  # under a supervisor.
  def start(_type, _args) do
    # Load environment variables from .env file
    DotenvParser.load_file(".env")

    # Get the server port from environment or fallback to 4000
    port =
      System.get_env("PORT")
      |> case do
        nil -> 4000
        str -> String.to_integer(str)
      end

    # List of children processes to supervise
    children = [
      {Plug.Cowboy, scheme: :http, plug: Translator.Router, options: [port: port]}
    ]

    # Supervisor options: one_for_one strategy, named supervisor
    opts = [strategy: :one_for_one, name: Translator.Supervisor]

     # Start the supervisor with the children
    Supervisor.start_link(children, opts)
  end
end
