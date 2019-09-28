use Mix.Config

config :websockets_listener, :rabbitmq,
  host: System.get_env("RABBITMQ_HOST"),
  port: System.get_env("RABBITMQ_PORT") |> String.to_integer,
  username: System.get_env("RABBITMQ_DEFAULT_USER"),
  password: System.get_env("RABBITMQ_DEFAULT_PASS"),
  ssl: false,
  heartbeat: 15
