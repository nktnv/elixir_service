defmodule WebsocketsListener.MixProject do
  use Mix.Project

  def project do
    [
      app: :websockets_listener,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WebsocketsListener.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:websockex, "~> 0.4.2"},
      {:plug_cowboy, "~> 2.0.1"},
      {:credo, "~> 1.0.3", except: :prod, runtime: false},
      {:code_reloader, github: "pilu/code_reloader"},
      {:amqp, "~> 1.3"}
    ]
  end
end
