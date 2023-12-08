defmodule AdventOfCode.CubeGame do
  alias AdventOfCode.CubeGame.Game
  @spec is_game_possible?(Game.t(), list(tuple())) :: bool
  def is_game_possible?(%Game{sets: sets},
        max_red: max_red,
        max_green: max_green,
        max_blue: max_blue
      ) do
    sets
    |> Enum.flat_map(fn set ->
      set
      |> Enum.filter(fn {color, number} ->
        case color do
          "green" -> max_green < number
          "blue" -> max_blue < number
          "red" -> max_red < number
        end
      end)
    end)
    |> Enum.empty?()
  end

  def get_minimum_set_of_cubes(%Game{sets: sets}) do
    mins = [red: 0, green: 0, blue: 0]

    sets
    |> Enum.reduce(mins, fn set, acc ->
      values =
        set
        |> Enum.map(fn {name, val} -> {String.to_atom(name), val} end)

      Keyword.merge(acc, values, fn _k, v1, v2 ->
        if v2 > v1, do: v2, else: v1
      end)
    end)
    |> Enum.into(%{})
  end

  def parse_games(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&Game.parse_game/1)
  end

  def sum_possible_game_ids(
        input,
        [max_red: _max_red, max_green: _max_green, max_blue: _max_blue] = params
      ) do
    parse_games(input)
    |> Enum.filter(fn game -> is_game_possible?(game, params) end)
    |> Enum.reduce(0, fn game, acc -> acc + game.id end)
  end
end
