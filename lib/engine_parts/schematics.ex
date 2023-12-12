defmodule AdventOfCode.EngineParts.Schematics do
  alias AdventOfCode.EngineParts.Schematics
  @blank_char "."
  @symbols ~w[+ = % * $ & # / - @]
  @type t() :: %__MODULE__{}
  defstruct [:lines]

  @spec new(String.t()) :: Schematics.t()
  def new(input) do
    input =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, ""))
      |> Enum.map(fn line ->
        line |> Enum.reject(&(&1 == ""))
      end)

    %Schematics{lines: input}
  end

  def get_point(_, y: y, x: x) when x < 0, do: nil
  def get_point(_, y: y, x: x) when y < 0, do: nil

  def get_point(%Schematics{lines: lines}, y: y, x: x) do
    char =
      lines
      |> Enum.at(y)
      |> Enum.at(x)

    with {:symbol, false} <- {:symbol, Enum.member?(@symbols, char)},
         {:empty, false} <- {:empty, char == @blank_char},
         {number, _} <- Integer.parse(char) do
      number
    else
      {:symbol, true} -> :symbol
      {:empty, true} -> :empty
    end
  end

  def get_adjacent(%Schematics{} = schematics, y: y, x: x) do
    [
      get_point(schematics, y: y - 1, x: x - 1),
      get_point(schematics, y: y - 1, x: x),
      get_point(schematics, y: y, x: x - 1),
      get_point(schematics, y: y, x: x),
      get_point(schematics, y: y + 1, x: x),
      get_point(schematics, y: y, x: x + 1),
      get_point(schematics, y: y + 1, x: x + 1),
      get_point(schematics, y: y - 1, x: x + 1),
      get_point(schematics, y: y + 1, x: x - 1)
    ]
    |> Enum.reject(&is_nil/1)
  end

  def is_number?(%Schematics{} = schematics, y: y, x: x) do
    schematics
    |> get_adjacent(y: y, x: x)
    |> Enum.member?(:symbol)
  end

  def get_number(%Schematics{lines: lines} = schematics, y: y, x: x) do
    if is_number?(schematics, y: y, x: x) do
      number = for j <- 0..x do
	Enum.at()
      end
    else
    end
  end
end
