defmodule Tetris.Brick do
  alias Tetris.{Brick, Points}

  @x_center 40

  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  @symbols ~w(i l z o t)a

  def x_center(), do: @x_center

  def color(%Brick{name: :l}), do: @blue
  def color(%Brick{name: :z}), do: @green
  def color(%Brick{name: :o}), do: @red 
  def color(%Brick{name: :t}), do: @yellow 
  def color(%Brick{name: :i}), do: @orange

  def new(attributes \\ []) do
    struct(__struct__(), attributes)
  end

  def new_random() do
    %Brick{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  def random_name() do
    @symbols
    |> Enum.shuffle()
    |> List.first()
  end

  def random_reflection() do
    [true, false]
    |> Enum.random()
  end

  def random_reflection() do
    [true, false]
    |> Enum.random()
  end

  def random_rotation() do
    [0, 90, 180, 270]
    |> Enum.random()
  end

  def up(brick) do
  end

  def move(%Brick{location: l} = brick, direction) when direction in [:down, :left, :right] do
    %{
      brick
      | location: move_point(l, direction)
    }
  end

  def move_point({x, y}, direction) do
    case direction do
      :down -> {x, y + 1}
      :left -> {x - 1, y}
      :right -> {x + 1, y}
    end
  end

  def spin_90(brick) do
    %{brick | rotation: rotate(brick.rotation)}
  end

  def rotate(270), do: 0
  def rotate(degrees), do: degrees + 90

  def shape(%{name: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def shape(%{name: :i}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end

  def shape(%{name: :o}) do
    [
      {2, 2},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def shape(%{name: :z}) do
    [
      {2, 2},
      {2, 3},
      {3, 3},
      {3, 4}
    ]
  end

  def shape(%{name: :t}) do
    [
      {2, 1},
      {2, 2},
      {3, 2},
      {2, 3}
    ]
  end

  def stringify(brick) do
    brick
    |> Brick.shape()
    |> Points.with_color(Brick.color(brick))
    |> Points.stringify()
  end
end

defimpl String.Chars, for: Tetris.Brick do
  alias Tetris.{Brick}

  def to_string(brick) do
    Brick.stringify(brick)
  end
end

defimpl Inspect, for: Tetris.Brick do
  import Inspect.Algebra
  alias Tetris.{Brick}

  def inspect(brick, opts) do
    concat([
      Brick.stringify(brick),
      "\n",
      "loc: #{inspect(brick.location)}, ",
      "refl: #{inspect(brick.reflection)}, ",
      "rot: #{inspect(brick.rotation)}"
    ])
  end
end
