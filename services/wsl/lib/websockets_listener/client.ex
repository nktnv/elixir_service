defmodule WebsocketsListener.Client do
  use WebSockex

  def start_link(url, state) do
    WebSockex.start_link(url, __MODULE__, state)
  end

  def init(state), do: {:ok, state}

  def handle_connect(_conn, state) do
    IO.puts("ws: connected")
    {:ok, state}
  end

  def handle_disconnect(_conn, state) do
    IO.puts("ws: disconnected")
    {:ok, state}
  end

  def handle_frame({:text, msg}, state) do
    value = Poison.decode!(msg)
    GenServer.call(state.parent_pid, {:ok, value})
    {:ok, state}
  end

  def handle_ping(:ping, state) do
    IO.puts("ws: ping frame")
    {:reply, :pong, state}
  end

  def handle_ping({:ping, msg}, state) do
    IO.puts("ws: ping frame")
    {:reply, {:pong, msg}, state}
  end
end
