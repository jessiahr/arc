defmodule ArcTest do
  use ExUnit.Case
  doctest Arc

  test "greets the world" do
    assert Arc.hello() == :world
  end
end
