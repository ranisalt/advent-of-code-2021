values =
  IO.stream()
  |> Enum.map(fn x ->
    String.trim_trailing(x) |> String.to_integer()
  end)

values
|> Enum.chunk_every(2, 1, :discard)
|> Enum.filter(fn [x, y] -> x < y end)
|> Enum.count()
|> IO.puts()

values
|> Enum.chunk_every(4, 1, :discard)
|> Enum.filter(fn [a, b, c, d] -> a + b + c < b + c + d end)
|> Enum.count()
|> IO.puts()
