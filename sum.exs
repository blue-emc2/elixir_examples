defmodule Sum do
  def sum(1), do: 1
  def sum(i), do: i + sum(i-1)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x,y))
end
