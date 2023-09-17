defmodule Aoc2015.D5 do
  alias Aoc2015.Common

  defp get_char_list(input_string) do
    input_string
    |> String.graphemes()
  end

  defp get_char_pair_list(input_string) do
    input_string
    |> String.graphemes()
    |> Enum.chunk_every(2, 1)
    |> Enum.filter(&(Enum.count(&1) == 2))
  end

  def has_min_vowels?(input_string, min_vowels) do
    get_char_list(input_string)
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, &(&1 + 1)) end)
    |> count_vowels()
    |> (&(&1 >= 3)).()
  end

  defp count_vowels(map_freq) do
    "aeiou"
    |> String.graphemes()
    |> Enum.reduce(0, fn vowel_char, acc -> acc + Map.get(map_freq, vowel_char, 0) end)
  end

  def has_pairs?(input_string) do
    input_string |> get_char_pair_list |> Enum.reduce_while(false, &same_char?/2)
  end

  defp same_char?([a, a], _), do: {:halt, true}
  defp same_char?(_, _), do: {:cont, false}

  def contains_blacklisted_substrings?(input_string) do
    ["ab", "cd", "pq", "xy"]
    |> Enum.filter(&String.contains?(input_string, &1))
    |> Enum.count()
    |> (&(&1 > 0)).()
  end

  def part1_check(input_string) do
    has_min_vowels?(input_string, 3) && has_pairs?(input_string) &&
      not contains_blacklisted_substrings?(input_string)
  end

  def part1 do
    Common.read_input_as_list_split_by_line(5) |> Enum.filter(&part1_check/1) |> Enum.count()
  end
end
