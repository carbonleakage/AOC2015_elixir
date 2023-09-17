defmodule Aoc2015Test do
  use ExUnit.Case
  alias Aoc2015.D1
  alias Aoc2015.D2
  alias Aoc2015.D3
  alias Aoc2015.D4
  alias Aoc2015.D5

  test "day1: going up one floor is (" do
    assert D1.calculate_current_floor(["("]) == 1
  end

  test "day1: going down one floor is )" do
    assert D1.calculate_current_floor([")"]) == -1
  end

  test "day1: these sequence of moves will finally end up in ground floor" do
    assert D1.calculate_current_floor(["(", ")"]) == 0
    assert D1.calculate_current_floor([")", "("]) == 0
    assert D1.calculate_current_floor(["(", "(", ")", ")"]) == 0
    assert D1.calculate_current_floor(["(", ")", "(", ")"]) == 0
  end

  test "day1: first position enters basement" do
    assert D1.find_position_that_enters_basement([")"]) == 1
  end

  test "day1: third position enters basement" do
    assert D1.find_position_that_enters_basement(["(", ")", ")"]) == 3
  end

  test "day1:fifth position enters basement" do
    assert D1.find_position_that_enters_basement(["(", ")", "(", ")", ")"]) == 5
    assert D1.find_position_that_enters_basement(["(", "(", ")", ")", ")"]) == 5
  end

  test "day2: calculate wrapping paper requirement" do
    assert D2.calcuate_wrapping_paper([2, 3, 4]) == 58
    assert D2.calcuate_wrapping_paper([1, 1, 10]) == 43
  end

  test "day2: calculate ribbon requirement" do
    assert D2.calculate_ribbon([2, 3, 4]) == 34
    assert D2.calculate_ribbon([1, 1, 10]) == 14
  end

  test "day3: calculate houses santa visited" do
    assert D3.calculate_houses_santa_visited([">"]) == 2
    assert D3.calculate_houses_santa_visited(["^", ">", "v", "<"]) == 4

    assert D3.calculate_houses_santa_visited(["^", "v", "^", "v", "^", "v", "^", "v", "^", "v"]) ==
             2
  end

  test "day3: calculate houses santa and robo visited" do
    assert D3.calculate_houses_santa_n_robo_visited(["^", "v"]) == 3
    assert D3.calculate_houses_santa_n_robo_visited(["^", ">", "v", "<"]) == 3

    assert D3.calculate_houses_santa_n_robo_visited([
             "^",
             "v",
             "^",
             "v",
             "^",
             "v",
             "^",
             "v",
             "^",
             "v"
           ]) ==
             11
  end

  @tag :slow
  test "day4: number that combined with secret key generates 5 zeroes" do
    assert D4.find_number("abcdef", 5) == 609_043
    assert D4.find_number("pqrstuv", 5) == 1_048_970
  end

  @tag :slow
  test "day4: crank that cpu, search 6 zeros md5" do
    assert D4.find_number("abcdef", 6) == 6_742_839
    assert D4.find_number("pqrstuv", 6) == 5_714_438
  end

  test "day5: has min 3 vowels" do
    assert "ugknbfddgicrmopn" |> D5.has_min_vowels?(3) == true
  end

  test "day5: does not contain black listed substrings" do
    assert "ugknbfddgicrmopn" |> D5.contains_blacklisted_substrings?() == false
  end

  test "day5: contains char pairs" do
    assert "ugknbfddgicrmopn" |> D5.has_pairs?() == true
  end

  test "day5: test part1" do
    assert "ugknbfddgicrmopn" |> D5.part1_check() == true
    assert "aaa" |> D5.part1_check() == true
    assert "jchzalrnumimnmhp" |> D5.part1_check() == false
    assert "haegwjzuvuyypxyu" |> D5.part1_check() == false
    assert "dvszwmarrgswjxmb" |> D5.part1_check() == false
  end
end
