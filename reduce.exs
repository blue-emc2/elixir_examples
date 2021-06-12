defmodule MyList do
  def reduce([], value, _) do
    value
  end

  def reduce([head | tail], value, func) do
    IO.puts "tail=#{inspect tail}, #{value}"
    reduce(tail, func.(head, value), func)
  end
end
