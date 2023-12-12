defmodule AdventOfCode.EnginePartsTest do
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
  describe "sum_part_numbers/1" do
    test "sum the parts of the engine", %{input: input} do


    end
  end
 
end
