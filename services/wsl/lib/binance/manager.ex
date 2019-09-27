defmodule Binance.Manager do
  use Supervisor

  alias Binance.{PublicListener}

  def start_link do
    IO.puts "starting binance supervisor.."
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(PublicListener, [])
    ]

    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end
end
