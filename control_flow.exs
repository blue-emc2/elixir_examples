defmodule FizzBuzz do
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    x = {n, rem(n, 3), rem(n, 5)}
    case x do
      {_, 0, 0} -> IO.puts "FizzBuzz"
      {_, 0, _} -> IO.puts "Fizz"
      {_, _, 0} -> IO.puts "Buzz"
      _ -> IO.puts n
    end
  end
end
