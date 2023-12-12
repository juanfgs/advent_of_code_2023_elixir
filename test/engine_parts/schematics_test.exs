defmodule AdventOfCode.EngineParts.SchematicsTest do
  use ExUnit.Case

  alias AdventOfCode.EngineParts.Schematics
  doctest AdventOfCode.EngineParts

  setup do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    {:ok, %{input: input}}
  end

  describe "get_point/2" do
    test "it returns the number at point", %{input: input} do
      assert 5 ==
               input
               |> Schematics.new()
               |> Schematics.get_point(y: 2, x: 3)
    end

    test "it returns whether the point is empty", %{input: input} do
      assert :empty ==
               input
               |> Schematics.new()
               |> Schematics.get_point(y: 2, x: 4)
    end

    test "it returns whether the point is symbol", %{input: input} do
      assert :symbol ==
               input
               |> Schematics.new()
               |> Schematics.get_point(y: 1, x: 3)
    end
  end

  describe "get_adjacent/2" do
    test "it returns a list with the adjacent symbols", %{input: input} do
      assert [:empty, :symbol, 3, 5, :empty, :empty, :empty, :empty, :empty] ==
               input
               |> Schematics.new()
               |> Schematics.get_adjacent(y: 2, x: 3)
    end
  end

  describe "is_number?/2" do
    test "it returns true if there is a symbol adjacent", %{input: input} do
      assert true ==
               input
               |> Schematics.new()
               |> Schematics.is_number?(y: 2, x: 3)
    end

    test "it returns false if there isn't  symbol adjacent", %{input: input} do
      assert false ==
               input
               |> Schematics.new()
               |> Schematics.is_number?(y: 0, x: 7)
    end
  end

  describe "get_number/2" do
    test "it returns the full number when it is a symbol", %{input: input} do
      assert 467 ==
               input
               |> Schematics.new()
               |> Schematics.get_number(y: 0, x: 2)
    end
  end
end
