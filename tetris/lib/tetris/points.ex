defmodule Tetris.Points do
  alias Tetris.{Brick}

  @l_shape [
    {2, 1},
    {2, 2},
    {2, 3},
    {3, 3}
  ]

  def translate(points, {x, y}) do
    points
    |> Enum.map(fn {dx, dy} ->
      {dx + x, dy + y}
    end)
  end

  def transpose(points) do
    Enum.map(points, &transpose_point/1)
  end

  def mirror(points) do
    Enum.map(points, &mirror_point/1)
  end

  def flip(points) do
    Enum.map(points, &flip_point/1)
  end

  def rotate_90(points) do
    points
    |> transpose
    |> mirror
  end

  def rotate(points, 0), do: rotate_90(points)

  def rotate(points, degrees) do
    points
    |> rotate_90()
    |> rotate(degrees - 90)
  end

  defp transpose_point({x, y}) do
    {y, x}
  end

  defp mirror_point({x, y}) do
    {4 - x, y}
  end

  defp flip_point({x, y}) do
    {x, 4 - y}
  end

  def pretty_print(points) do
    points
    |> stringify()
    |> IO.puts()

    points
  end

  def stringify(points \\ @l_shape) do
    for x <- 1..4, y <- 1..4 do
      if {x, y} in points,
        do: {x, y, "■"},
        else: {x, y, "□"}
    end
    |> Enum.chunk_every(4)
    |> Enum.map_join(
      "\n",
      fn line -> 
        Enum.map_join(line, "", &elem(&1, 2))
      end
    )
  end

  def with_color(points, color) do
    Enum.map(points, fn point -> add_color(point, color) end)
  end
  
  def add_color({_x, _y, _c}, color), do: colorpoint
  def add_color({x, y}, color), do: {x, y, color}
end
