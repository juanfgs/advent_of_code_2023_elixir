defmodule AdventOfCode.EngineParts do
  alias AdventOfCode.EngineParts.Schematics

  @spec parse_schematics(binary()) :: Schematics.t()
  def parse_schematics(input) do
    input
    |> Schematics.new()
  end

  def sum_part_numbers(%Schematics{} = schematics) do

  end

end
