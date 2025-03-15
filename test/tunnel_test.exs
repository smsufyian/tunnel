defmodule TunnelTest do
  use ExUnit.Case
  doctest Tunnel

  test "greets the world" do
    assert Tunnel.hello() == :world
  end
end
