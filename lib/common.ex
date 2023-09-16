defmodule Aoc2015.Common do
  def read_input(day_number) do
    "assets/day#{day_number}_input.txt"
    |> File.read!()
    |> String.trim()
  end

  def read_input_as_list(day_number) do
    read_input(day_number) |> String.split("", trim: true)
  end
end
