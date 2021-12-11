values = IO.stream() |> Enum.map(&String.split/1)

values
|> Enum.reduce({0, 0}, fn [dir, delta], {x, y} ->
  d = String.to_integer(delta)

  case dir do
    "forward" ->
      {x, y + d}

    "up" ->
      {x - d, y}

    "down" ->
      {x + d, y}
  end
end)
|> Tuple.product()
|> IO.puts()

values
|> Enum.reduce({0, 0, 0}, fn [dir, delta], {aim, depth, position} ->
  d = String.to_integer(delta)

  case dir do
    "forward" ->
      {aim, depth + aim * d, position + d}

    "up" ->
      {aim - d, depth, position}

    "down" ->
      {aim + d, depth, position}
  end
end)
|> Tuple.delete_at(0)
|> Tuple.product()
|> IO.puts()
