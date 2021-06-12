defmodule MyList do
  def mapsum([], value, _) do
    value
  end

  def mapsum([head | tail], func) do
    mapsum(tail, func.(head), func)
  end

  def mapsum([head | tail], value, func) do
    mapsum(tail, value + func.(head), func)
  end

  # 全部同じ数値だと落ちる
  def max([head | tail]) do
    max = head
    max_search(tail, max)
  end

  def max_search([head | tail], max) when head > max do
    max = head
    max_search(tail, max)
  end

  def max_search([head | tail], max) when head < max do
    max_search(tail, max)
  end

  def max_search([], max) do
    max
  end

  # def caesarは後回し

  # ListsAndRecursion-4
  # c "my_list.exs"
  # MyList.span(3, 7)
  # > [3, 4, 5, 6, 7]
  # あまりにも分からなかったので他の人の回答を参考にした
  def span(from, to) do
    span(from, to, [])
  end

  def span(from, to, list) when from == to do
    list ++ [to]
  end

  def span(from, to, list) do
    list ++ [ from | span(from + 1, to, list) ]
  end

  # 微妙に違うけど2からnの素数を求める
  # iex(8)> for x <- MyList.span(2, 100), rem(x, 2) != 0, do: x
end
