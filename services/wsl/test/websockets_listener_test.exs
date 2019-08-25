defmodule WebsocketsListenerTest do
  use ExUnit.Case
  doctest WebsocketsListener

  test "greets the world" do
    assert WebsocketsListener.hello() == :world
  end
end
