defmodule Aoc2015.D6 do
  alias Aoc2015.Common

  @spec create_grid(integer) :: Map.t()
  def create_grid(grid_size) do
    grid_helper(0, grid_size, 0, grid_size, %{}, fn _ -> 0 end)
  end

  defp grid_helper(start_x, end_x, start_y, end_y, base_grid, fill_function) do
    Range.to_list(start_x..end_x)
    |> Enum.reduce(base_grid, fn i, x_acc ->
      start_y..end_y
      |> Enum.reduce(x_acc, fn j, y_acc -> Map.update(y_acc, {i, j}, 0, fill_function) end)

      # |> Map.merge(x_acc)
    end)
  end

  defp parse_instructions(instruction) do
    pattern =
      ~r/(?<light_action>[\sa-z]*)\s(?<start_x>\d*),(?<start_y>\d*) through (?<end_x>\d*),(?<end_y>\d*)/

    matches = Regex.named_captures(pattern, instruction)

    ["end_x", "end_y", "start_x", "start_y"]
    |> Enum.reduce(matches, fn key, map -> Map.replace(map, key, String.to_integer(map[key])) end)
  end

  defp execute_instruction_helper_part1(
         %{
           "light_action" => light_action,
           "start_x" => start_x,
           "end_x" => end_x,
           "start_y" => start_y,
           "end_y" => end_y
         },
         grid
       ) do
    case light_action do
      "turn on" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn _ -> 1 end)

      "turn off" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn _ -> 0 end)

      "toggle" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn light_state ->
          Map.get(%{0 => 1, 1 => 0}, light_state)
        end)
    end
  end

  defp execute_instruction_helper_part2(
         %{
           "light_action" => light_action,
           "start_x" => start_x,
           "end_x" => end_x,
           "start_y" => start_y,
           "end_y" => end_y
         },
         grid
       ) do
    case light_action do
      "turn on" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn light_brightness ->
          light_brightness + 1
        end)

      "turn off" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn light_brightness ->
          max(0, light_brightness - 1)
        end)

      "toggle" ->
        grid_helper(start_x, end_x, start_y, end_y, grid, fn light_brightness ->
          light_brightness + 2
        end)
    end
  end

  def execute_instruction(instruction, grid, helper_function) do
    instruction |> parse_instructions() |> helper_function.(grid)
  end

  def part1 do
    grid = create_grid(999)

    Common.read_input_as_list_split_by_line(6)
    |> Enum.reduce(grid, fn inst, acc ->
      execute_instruction(inst, acc, &execute_instruction_helper_part1/2)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def part2 do
    grid = create_grid(999)

    Common.read_input_as_list_split_by_line(6)
    |> Enum.reduce(grid, fn inst, acc ->
      execute_instruction(inst, acc, &execute_instruction_helper_part2/2)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
