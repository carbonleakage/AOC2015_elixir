defmodule Aoc2015Test do
  use ExUnit.Case
  alias Aoc2015.D1

  test "going up one floor is (" do
    assert D1.calculate_current_floor(["("]) == 1
  end

  test "going down one floor is )" do
    assert D1.calculate_current_floor([")"]) == -1
  end

  test "these sequence of moves will finally end up in ground floor" do
    assert D1.calculate_current_floor(["(", ")"]) == 0
    assert D1.calculate_current_floor([")", "("]) == 0
    assert D1.calculate_current_floor(["(", "(", ")", ")"]) == 0
    assert D1.calculate_current_floor(["(", ")", "(", ")"]) == 0
  end

  test "first position enters basement" do
    assert D1.find_position_that_enters_basement([")"]) == 1
  end

  test "third position enters basement" do
    assert D1.find_position_that_enters_basement(["(", ")", ")"]) == 3
  end

  test "fifth position enters basement" do
    assert D1.find_position_that_enters_basement(["(", ")", "(", ")", ")"]) == 5
    assert D1.find_position_that_enters_basement(["(", "(", ")", ")", ")"]) == 5
  end
end
