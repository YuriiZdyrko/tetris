defmodule Tetris.BrickTest do
    use ExUnit.Case

    alias Tetris.Brick

    test "Creates a new brick" do
        assert new_brick().name == :i
    end

    defp new_brick, do: Brick.new()
end