defmodule Aoc2015.D3 do
  alias Aoc2015.Common

  defp evaluate_move(">", {x, y}), do: {x + 1, y}
  defp evaluate_move("<", {x, y}), do: {x - 1, y}
  defp evaluate_move("^", {x, y}), do: {x, y + 1}
  defp evaluate_move("v", {x, y}), do: {x, y - 1}

  defp make_move([next_move | []], location, houses_visited) do
    update_house_visited(houses_visited, location)
    |> update_house_visited(evaluate_move(next_move, location))
  end

  defp make_move([next_move | tail], location, houses_visited) do
    make_move(
      tail,
      evaluate_move(next_move, location),
      update_house_visited(houses_visited, location)
    )
  end

  defp update_house_visited(houses_visited, location) do
    Map.has_key?(houses_visited, location) |> maybe_update_map(houses_visited, location)
  end

  defp maybe_update_map(true, houses_visited, location) do
    Map.replace(
      houses_visited,
      location,
      Map.get(houses_visited, location) + 1
    )
  end

  defp maybe_update_map(false, houses_visited, location),
    do: Map.put(houses_visited, location, 1)

  def calculate_houses_santa_visited(moves) do
    make_move(moves, {0, 0}, Map.new()) |> Enum.count()
  end

  def calculate_houses_santa_n_robo_visited(moves) do
    n = Enum.count(moves)
    houses_santa_visited = Enum.slice(moves, 0..n//2) |> make_move({0, 0}, Map.new())
    houses_robo_visited = Enum.slice(moves, 1..n//2) |> make_move({0, 0}, Map.new())
    Map.merge(houses_robo_visited, houses_santa_visited) |> Enum.count()
  end

  def part1 do
    Common.read_input_as_list_split_by_character(3) |> calculate_houses_santa_visited()
  end

  def part2 do
    Common.read_input_as_list_split_by_character(3) |> calculate_houses_santa_n_robo_visited()
  end
end
