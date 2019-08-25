defmodule Binance.PublicListener do
  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{})
    WebsocketsListener.Client.start_link(generate_ws_url(), %{ parent_pid: pid })
    {:ok, pid}
  end

  def init(state) do
    IO.puts "init public listener"
    {:ok, state}
  end

  def handle_call({:ok, msg}, _from, state) do
    IO.inspect(msg)
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
