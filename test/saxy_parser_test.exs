defmodule SaxyParserTest do
  use ExUnit.Case
  doctest SaxyParser

  test "greets the world" do
    assert SaxyParser.hello() == :world
  end
end
