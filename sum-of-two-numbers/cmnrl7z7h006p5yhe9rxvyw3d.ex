[a, b] =
  IO.read(:stdio, :all)
  |> String.split()
  |> Enum.map(&String.to_integer/1)

IO.puts(a + b)