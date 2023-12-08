defmodule AdventOfCode.CubeGame.GameTest do
  use ExUnit.Case

  alias AdventOfCode.CubeGame.Game
  doctest AdventOfCode.CubeGame

  describe "parse_game1" do
    test "it should parse the existing game from a string" do
      input = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"

      game = Game.parse_game(input)
      assert game.id == 3
      assert game.total_green_cubes == 26
      assert game.total_blue_cubes == 11
      assert game.total_red_cubes == 25

      assert game.sets == [
               [{"green", 8}, {"blue", 6}, {"red", 20}],
               [{"blue", 5}, {"red", 4}, {"green", 13}],
               [{"green", 5}, {"red", 1}]
             ]
    end
  end
end
