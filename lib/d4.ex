defmodule Aoc2015.D4 do
  def find_number(secret, number_of_zeroes) do
    find_number_helper(secret, 0, number_of_zeroes, false)
  end

  defp find_number_helper(secret, num, number_of_zeroes, false) do
    find_number_helper(
      secret,
      num + 1,
      number_of_zeroes,
      md5_hash_starts_with_5_zeros?(secret, num + 1, number_of_zeroes)
    )
  end

  defp find_number_helper(_, num, _, true) do
    num
  end

  defp md5_hash_starts_with_5_zeros?(secret, num, number_of_zeroes) do
    :crypto.hash(:md5, "#{secret}#{num}")
    |> Base.encode16()
    |> String.slice(0..(number_of_zeroes - 1))
    |> check_md5(number_of_zeroes)
  end

  defp check_md5(x, number_of_zeroes), do: x == String.duplicate("0", number_of_zeroes)

  def part1 do
    find_number("bgvyzdsv", 5)
  end

  def part2 do
    find_number("bgvyzdsv", 6)
  end
end
