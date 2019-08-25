defmodule WebsocketsListener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias WebsocketsListener.Endpoint
  alias WebsocketsListener.CoinbaseClient

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      Endpoint,
      supervisor(Binance.Manager, [], name: Binance.Manager)
    ]

    # - self
    # -- Endpoint
    # -- Binance
    # --- Public
    # --- Users
    # -- Coincap
    # --- Public

    opts = [strategy: :one_for_one, name: WebsocketsListener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def children(_), do: []
end
