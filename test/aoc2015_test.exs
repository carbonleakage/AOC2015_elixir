defmodule Aoc2015Test do
  use ExUnit.Case
  alias Aoc2015.D1
  alias Aoc2015.D2
  alias Aoc2015.D3

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
end
