defmodule RdescTest do
  use ExUnit.Case
  doctest Rdesc

  test "greets the world" do
    assert Rdesc.hello() == :world
  end
end
