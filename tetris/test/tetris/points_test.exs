defmodule Tetris.PointsTest do
  use ExUnit.Case
  alias Tetris.{Points, Brick}

  test "translates points" do
    points =
      [name: :i]
      |> Brick.new()
      |> Brick.shape()
      |> Points.translate({1, 1})

    assert [
             {3, 2},
             {3, 3},
             {3, 4},
             {3, 5}
           ] = points
  end

  test "mirror-flip" do
    assert [{1, 1}] =
             [{1, 1}]
             |> Points.mirror()
             |> assert_point({3, 1})
             |> Points.flip()
             |> assert_point({3, 3})
             |> Points.mirror()
             |> assert_point({1, 3})
             |> Points.flip()
             |> assert_point({1, 1})
  end

  test "rotate points" do
    result =
      [name: :l]
      |> Brick.new()
      |> Brick.shape()
      |> Points.rotate(90)
      |> Points.rotate(90)

    assert [{2, 1}, {2, 2}, {2, 3}, {3, 3}] = result
  end

  test "rotate points 2" do
    result =
      [name: :l]
      |> Brick.new()
      |> Brick.shape()
      |> Points.rotate(90)
      |> Points.rotate(90)
      |> Points.rotate(90)
      |> Points.rotate(90)

    assert points = result
  end

  defp assert_point([point], point), do: [point]
end
