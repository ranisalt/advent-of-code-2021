defmodule Day04 do
  defp wins_rows(seq, board) do
    Enum.chunk_every(board, 5)
    |> Enum.map(fn x ->
      MapSet.new(x)
      |> MapSet.difference(seq)
      |> Enum.empty?()
    end)
    |> Enum.any?()
  end

  defp wins_cols(seq, board) do
    Enum.map(0..4, fn x ->
      Enum.drop(board, x)
      |> Enum.take_every(5)
      |> MapSet.new()
      |> MapSet.difference(seq)
      |> Enum.empty?()
    end)
    |> Enum.any?()
  end

  def wins(seq, board) do
    wins_rows(seq, board) or wins_cols(seq, board)
  end
end

seq =
  IO.read(:stdio, :line)
  |> String.trim_trailing()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

boards =
  IO.stream()
  |> Enum.map(&String.trim_trailing/1)
  |> Enum.chunk_every(6)
  |> Enum.map(fn x ->
    Enum.drop(x, 1)
    |> Enum.flat_map(&String.split/1)
    |> Enum.map(&String.to_integer/1)
  end)

Enum.find_value(5..length(seq), fn x ->
  Enum.find_value(boards, fn board ->
    seq_set = Enum.take(seq, x) |> MapSet.new()

    if Day04.wins(seq_set, board) do
      score =
        MapSet.new(board)
        |> MapSet.difference(seq_set)
        |> Enum.sum()

      score * Enum.at(seq, x - 1)
    end
  end)
end)
|> IO.puts()

{x, board} =
  Enum.reduce_while(5..length(seq), {5, boards}, fn x, {_, boards} ->
    seq_set = Enum.take(seq, x) |> MapSet.new()

    boards = Enum.filter(boards, &(not Day04.wins(seq_set, &1)))
    if length(boards) == 1, do: {:halt, {x, List.first(boards)}}, else: {:cont, {x, boards}}
  end)

Enum.find_value(x..length(seq), fn x ->
  seq_set = Enum.take(seq, x) |> MapSet.new()

  if Day04.wins(seq_set, board) do
    score =
      MapSet.new(board)
      |> MapSet.difference(seq_set)
      |> Enum.sum()

    score * Enum.at(seq, x - 1)
  end
end)
|> IO.puts()
