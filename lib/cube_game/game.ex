defmodule AdventOfCode.CubeGame.Game do
  @type t() :: %__MODULE__{}
  alias AdventOfCode.CubeGame.Game
  defstruct [:id, total_red_cubes: 0, total_blue_cubes: 0, total_green_cubes: 0, sets: []]

  @spec parse_game(String.t()) :: Game.t() | atom()
  def parse_game(input) do
    sets = extract_sets(input)
    cubes = extract_total_cubes(sets)

    %__MODULE__{
      id: extract_id(input),
      total_red_cubes: cubes["red"],
      total_green_cubes: cubes["green"],
      total_blue_cubes: cubes["blue"],
      sets: sets
    }
  end

  defp extract_id(input) do
    {id, _} =
      input
      |> String.split(":")
      |> Enum.at(0)
      |> String.split(" ")
      |> Enum.at(1)
      |> Integer.parse()

    id
  end

  defp extract_sets(input) do
    input
    |> String.split(":")
    |> Enum.at(1)
    |> String.split(";")
    |> Enum.map(fn set ->
      set
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [number, color] ->
        {number, _} = Integer.parse(number)
        {color, number}
      end)
    end)
  end

  defp extract_total_cubes(input) do
    cubes =
      %{"green" => 0, "blue" => 0, "red" => 0}

    input
    |> Enum.reduce(cubes, fn set, acc ->
      set
      |> Enum.reduce(acc, fn {color, number}, acc ->
        %{acc | color => acc[color] + number}
      end)
    end)
  end
end
