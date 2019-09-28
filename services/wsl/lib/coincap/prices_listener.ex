defmodule Coincap.PricesListener do
  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{})
    WebsocketsListener.Client.start_link(generate_ws_url(), %{ parent_pid: pid })
    {:ok, pid}
  end

  def init(state) do
    IO.puts "init coincap listener"
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
      "exs.coincap_prices",
      Poison.encode!(msg)
    )
    {:reply, :ok, state}
  end

  # def handle_info({:ok, value}, state) do
  #   IO.inspect("info")
  #   {:reply, "#{value} add",state + value}
  # end

  # def handle_cast({:ok, value}, state) do
  #   IO.inspect("cast")
  #   {:reply, "#{value} add",state + value}
  # end

  defp generate_ws_url, do: "wss://ws.coincap.io/prices?assets=ALL"
end
