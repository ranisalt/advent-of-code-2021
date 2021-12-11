values =
  IO.stream()
  |> Enum.map(&String.trim_trailing/1)
  |> Enum.map(&String.graphemes/1)

Enum.zip_with(values, fn x ->
  case Enum.count(x, &(&1 == "1")) >= Enum.count(x) / 2 do
    true -> ["1", "0"]
    false -> ["0", "1"]
  end
end)
|> Enum.zip_with(&Enum.join/1)
|> Enum.map(&String.to_integer(&1, 2))
|> Enum.product()
|> IO.puts()

digits = List.first(values) |> length()

0..(digits - 1)
|> Enum.reduce({values, values}, fn i, {oxygen, carbon} ->
  oxygen_ones = Enum.count(oxygen, &(Enum.at(&1, i) == "1"))
  carbon_zeros = Enum.count(carbon, &(Enum.at(&1, i) == "0"))

  oxygen_most_common = if oxygen_ones >= length(oxygen) / 2, do: "1", else: "0"
  carbon_least_common = if carbon_zeros <= length(carbon) / 2, do: "0", else: "1"

  {
    Enum.filter(oxygen, &(Enum.at(&1, i) == oxygen_most_common)),
    if length(carbon) > 1 do
      Enum.filter(carbon, &(Enum.at(&1, i) == carbon_least_common))
    else
      carbon
    end
  }
end)
|> Tuple.to_list()
|> Enum.map(&(Enum.at(&1, 0) |> Enum.join() |> String.to_integer(2)))
|> Enum.product()
|> IO.puts()
