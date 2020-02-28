defmodule Tetris.BrickTest do
  use ExUnit.Case

  alias Tetris.Brick

  test "Creates a new brick" do
    assert new_brick().name == :i
  end

  test "Creates a new random brick" do
    actual = Brick.new_random()

    assert actual.name in ~w(i l z t o)a
    assert actual.rotation in [0, 90, 270, 180]
    assert actual.reflection in [true, false]
  end

  test "should manipulate brick" do
    assert %Brick{
             location: {41, 1},
             rotation: 90
           } =
             new_brick()
             |> Brick.move(:left)
             |> Brick.move(:right)
             |> Brick.move(:right)
             |> Brick.move(:down)
             |> Brick.spin_90()
  end

  test "should return points for shape" do
    points = new_brick(name: :i) |> Brick.shape()

    assert [
             {2, 1},
             {2, 2},
             {2, 3},
             {2, 4}
           ] = points
  end

  test "should convert brick to string" do
    actual = new_brick([name: :l]) |> Brick.stringify()
    expected = "□□□□\n■■■□\n□□■□\n□□□□"
    assert actual == expected
  end

  test "should inspect bricks" do
    expected = """
    □□□□
    ■■■□
    □□■□
    □□□□
    loc: {#{Brick.x_center()}, 0}, refl: false, rot: 0
    """
    
    actual = new_brick([name: :l]) |> inspect()

    assert "#{actual}\n" == expected
  end

  defp new_brick(attrs \\ []), do: Brick.new(attrs)
end
