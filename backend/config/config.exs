import Config;

# Get the server port from environment variable or fallback to 4000
port =
  System.get_env("PORT") |> case do
    nil -> 4000;
    str -> String.to_integer(str);
  end;

config :translator, port: port;
