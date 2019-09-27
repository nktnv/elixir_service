defmodule Binance.PublicListener do
  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{})
    WebsocketsListener.Client.start_link(generate_ws_url(), %{ parent_pid: pid })
    {:ok, pid}
  end

  def init(state) do
    IO.puts "init public listener"
    :timer.sleep(15000)
    params = Application.get_env(:websockets_listener, :rabbitmq)
    {:ok, connection} = AMQP.Connection.open(params)
    {:ok, channel} = AMQP.Channel.open(connection)
    {:ok, Map.put(state, :msg_queue_channel, channel)}
  end

  def handle_call({:ok, msg}, _from, state) do
    AMQP.Basic.publish(
      state.msg_queue_channel,
      "",
      "exs.binance_pairs_tickers",
      Poison.encode!(msg)
    )
    {:reply, :ok, state}
  end

  def handle_info({:ok, value}, state) do
    IO.inspect("info")
    {:reply, "#{value} add",state + value}
  end

  def handle_cast({:ok, value}, state) do
    IO.inspect("cast")
    {:reply, "#{value} add",state + value}
  end

  defp generate_ws_url, do: "wss://stream.binance.com:9443/ws/!ticker@arr"
end
# dcd run --rm wsl iex --cookie secret --name local@wsl:4000 -e "Node.connect(:'remote@wsl:4000')" -S mix run --no-start
