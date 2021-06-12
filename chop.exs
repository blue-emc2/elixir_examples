defmodule Chop do
  def guess(actual, range) do
    (min..max = range)
    mid = div(max + min, 2)

    IO.puts("Is it #{mid}")
    guess(actual, range, mid)
  end

  def guess(actual, range, mid) when actual < mid do
    min..max = range
    IO.puts("< #{actual} #{min}, #{mid}, #{max}")
    guess(actual, min..mid)
  end

  def guess(actual, range, mid) when actual > mid do
    min..max = range
    IO.puts("> #{actual} #{min}, #{mid}, #{max}")
    guess(actual, mid..max)
  end

  def guess(actual, range, mid) when actual == mid do
    IO.puts("#{mid}")
  end
end

# guess(273, 1..1000)の場合、min+max/2で推測値をもとめる
# 推測値が1..500が500~1000のどちらに所属するかガードで調べる
# 調べたら新しいrangeを渡す
# 見つかるまで繰り返す
