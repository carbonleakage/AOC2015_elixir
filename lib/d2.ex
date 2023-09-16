defmodule Aoc2015.D2 do
  alias Aoc2015.Common

  def part1 do
    Common.read_input_as_list_split_by_line(2)
    |> Enum.map(&preprocess_input/1)
    |> Enum.reduce(0, fn x, acc -> calcuate_wrapping_paper(x) + acc end)
  end

  def part2 do
    Common.read_input_as_list_split_by_line(2)
    |> Enum.map(&preprocess_input/1)
    |> Enum.reduce(0, fn x, acc -> calculate_ribbon(x) + acc end)
  end

  defp calculate_side_areas([l, b, h]) do
    [l * b, b * h, l * h]
  end

  defp calculate_side_perimeters([l, b, h]) do
    [2 * (l + b), 2 * (b + h), 2 * (l + h)]
  end

  defp calculate_volume([l, b, h]) do
    l * b * h
  end

  defp preprocess_input(input_string) do
    input_string |> String.split("x", trim: true) |> Enum.map(&String.to_integer/1)
  end

  defp calculate_surface_area(side_areas) do
    side_areas |> Enum.map(&(2 * &1)) |> Enum.reduce(fn x, acc -> x + acc end)
  end

  defp calculate_min_surface_area(side_areas) do
    side_areas |> Enum.min()
  end

  def calcuate_wrapping_paper(side_dimension) do
    side_areas = calculate_side_areas(side_dimension)
    (side_areas |> calculate_surface_area()) + (side_areas |> calculate_min_surface_area)
  end

  def calculate_ribbon(side_dimensions) do
    (side_dimensions |> calculate_side_perimeters |> Enum.min()) +
      (side_dimensions |> calculate_volume)
  end
end
