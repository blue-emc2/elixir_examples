defmodule MyEnum do

  def all?([head | tail], func) do
    all?(tail, func.(head), func)
  end

  def all?([head | tail], result, func) when result == true do
    all?(tail, func.(head), func)
  end

  def all?([_head | _tail], result, func) when result == false do
    all?([], false, func)
  end

  def all?([], result, _func) do
    result
  end

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def each([], _func) do
    :ok
  end

  def filter([head | tail], func) do
    filter([head | tail], [], func)
  end

  def filter([head | tail], r, func) do
    if func.(head) == true do
      filter(tail, r ++ [head], func)
    else
      filter(tail, r, func)
    end
  end

  def filter([], r, _func) do
    r
  end

  def split([head | tail], count) do
    split(tail, [head], count - 1)
  end

  def split([head | tail], tmp, count) do
    IO.puts("1 count=#{count} head=#{inspect head} tail=#{inspect tail} tmp=#{inspect tmp}")
    if count == 0 do
      IO.puts("0 tail=#{inspect tail}")
      { tmp, [head] ++ tail }
    else
      split(tail, tmp ++ [head], count - 1)
    end
  end
end

# all?
# iex(1)> list = Enum.to_list 1..5
# [1, 2, 3, 4, 5]
# iex(3)> Enum.all?(list, &(&1 < 4))
# false

# each
# iex(1)> Enum.each(["one", "two", "three"], fn(s) -> IO.puts(s) end)
# one
# two
# three
# :ok

# filter
# iex(8)> Enum.filter([1, 2, 3, 4], fn(x) -> rem(x, 2) == 0 end)
# [2, 4]

# split
# iex(14)> Enum.split([1, 2, 3], 2)
# {[1, 2], [3]}
# iex(15)> Enum.split([1, 2, 3], 1)
# {[1], [2, 3]}
