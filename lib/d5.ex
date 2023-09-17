defmodule Aoc2015.D5 do
  alias Aoc2015.Common

  defp get_char_list(input_string) do
    input_string
    |> String.graphemes()
  end

  defp get_char_chunk_list(input_string, chunk_length) do
    input_string
    |> String.graphemes()
    |> Enum.chunk_every(chunk_length, 1)
    |> Enum.filter(&(Enum.count(&1) == chunk_length))
  end

  def has_min_vowels?(input_string, min_vowels) do
    get_char_list(input_string)
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, &(&1 + 1)) end)
    |> count_vowels()
    |> (&(&1 >= min_vowels)).()
  end

  defp count_vowels(map_freq) do
    "aeiou"
    |> String.graphemes()
    |> Enum.reduce(0, fn vowel_char, acc -> acc + Map.get(map_freq, vowel_char, 0) end)
  end

  def has_pairs?(input_string) do
    input_string |> get_char_chunk_list(2) |> Enum.reduce_while(false, &same_char_pair?/2)
  end

  defp same_char_pair?([a, a], _), do: {:halt, true}
  defp same_char_pair?(_, _), do: {:cont, false}

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

  def pair_with_letter_between(input_string) do
    input_string |> get_char_chunk_list(3) |> Enum.reduce_while(false, &same_start_end_char?/2)
  end

  defp same_start_end_char?([a, _, a], _), do: {:halt, true}
  defp same_start_end_char?(_, _), do: {:cont, false}

  def pair_appears_twice?(input_string) do
    pair_repeat_check(false, input_string)
  end

  defp pair_repeat_check(false, ""), do: false

  defp pair_repeat_check(false, input_string) do
    String.slice(input_string, 0..1)
    |> check_substring?(String.slice(input_string, 2..-1))
    |> pair_repeat_check(String.slice(input_string, 1..-1))
  end

  defp pair_repeat_check(true, _), do: true

  defp check_substring?(sub_string, remaining_string),
    do: String.contains?(remaining_string, sub_string)

  def part2_check(input_string) do
    pair_appears_twice?(input_string) && pair_with_letter_between(input_string)
  end

  def part2 do
    Common.read_input_as_list_split_by_line(5) |> Enum.filter(&part2_check/1) |> Enum.count()
  end
end
