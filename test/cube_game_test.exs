defmodule AdventOfCode.CubeGameTest do
  use ExUnit.Case

  alias AdventOfCode.CubeGame.Game
  alias AdventOfCode.CubeGame
  doctest AdventOfCode.CubeGame

  describe "is_game_possible?1" do
    test "it should return false if game is not possible" do
      game =
        %Game{
          id: 3,
          sets: [
            [{"green", 8}, {"blue", 6}, {"red", 20}],
            [{"blue", 5}, {"red", 4}, {"green", 13}],
            [{"green", 5}, {"red", 1}]
          ]
        }

      assert false == CubeGame.is_game_possible?(game, max_red: 12, max_green: 13, max_blue: 14)
    end

    test "it should return true if game is not possible" do
      game =
        %Game{
          id: 5,
          sets: [
            [{"green", 3}, {"blue", 1}, {"red", 6}],
            [{"blue", 2}, {"red", 1}, {"green", 2}]
          ]
        }

      assert true == CubeGame.is_game_possible?(game, max_red: 12, max_green: 13, max_blue: 14)
    end
  end

  describe "sum_possible_game_ids/1" do
    test "should return the sum of games that are possible " do
      input = ~S"""
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      assert 8 == CubeGame.sum_possible_game_ids(input, max_red: 12, max_green: 13, max_blue: 14)
    end
  end

  describe "get_minimum_set_of_cubes/1" do
    test "should return the sum of games that are possible " do
      games =
        ~S"""
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """
        |> CubeGame.parse_games()

      assert %{red: 4, blue: 6, green: 2} == CubeGame.get_minimum_set_of_cubes(Enum.at(games, 0))
      assert %{red: 1, blue: 4, green: 3} == CubeGame.get_minimum_set_of_cubes(Enum.at(games, 1))

      assert %{red: 20, blue: 6, green: 13} ==
               CubeGame.get_minimum_set_of_cubes(Enum.at(games, 2))

      assert %{red: 14, blue: 15, green: 3} ==
               CubeGame.get_minimum_set_of_cubes(Enum.at(games, 3))

      assert %{red: 6, blue: 2, green: 3} == CubeGame.get_minimum_set_of_cubes(Enum.at(games, 4))
    end
  end

  describe "solve the exercise" do
    test "it should solve the exercise" do
      input = File.read!("test/support/cube_game/input")
      games = CubeGame.parse_games(input)

      assert 63700 ==
               games
               |> Enum.reduce(0, fn item, acc ->
                 %{red: red, blue: blue, green: green} = CubeGame.get_minimum_set_of_cubes(item)
                 acc + red * blue * green
               end)
    end
  end
end
