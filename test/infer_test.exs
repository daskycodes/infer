defmodule InferTest do
  use ExUnit.Case
  doctest Infer
  doctest Infer.Image

  test "greets the world" do
    assert Infer.hello() == :world
  end
end
