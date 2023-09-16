defmodule Aoc2015.D1 do
  alias Aoc2015.Common

  def part1() do
    Common.read_input_as_list(1)
    |> calculate_current_floor
  end

  def part2() do
    Common.read_input_as_list(1)
    |> find_position_that_enters_basement
  end

  def calculate_current_floor(input_floor_list) do
    input_floor_list
    |> Enum.reduce(0, fn floor_sign, acc -> parse_floor_sign(floor_sign) + acc end)
  end

  defp parse_floor_sign("("), do: 1
  defp parse_floor_sign(")"), do: -1

  def find_position_that_enters_basement(input_floor_list) do
    input_floor_list |> Enum.with_index(1) |> check_when_entering_basement(0)
  end

  defp check_when_entering_basement([{floor_sign, instruction_position} | tail], current_floor) do
    (parse_floor_sign(floor_sign) + current_floor)
    |> maybe_entered_basement(instruction_position, tail)
  end

  defp maybe_entered_basement(-1, instruction_position, _), do: instruction_position

  defp maybe_entered_basement(current_floor, _, tail),
    do: check_when_entering_basement(tail, current_floor)
end
