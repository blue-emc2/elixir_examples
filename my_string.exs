defmodule MyString do

  # iex(17)> MyString.pp? 'hoge'
  # 111
  # 103
  # 101
  # true
  def pp?([head | tail]) do
    ppp?(tail)
  end

  def ppp?([head | tail]) when head > 31 and head < 127 do
    IO.puts head
    ppp?(tail)
  end

  def ppp?([head | tail]) when head < 32 or head > 126 do
    IO.puts head
    false
  end
  def ppp?([]), do: true

  # MyString.anagram?("listen", "enlist")
  # 文字列を期待する
  def anagram?(word1, word2) do
    anagram(word1, word2)
  end

  def anagram(word1, word2) do
    sorted = fn (word) -> word |> String.codepoints |> Enum.sort end
    sorted.(word1) == sorted.(word2)
  end

  # 文字列で渡すとlengthがListを期待しているのでエラーがでる
  # def anagram(word1, word2) when length(word1) != length(word2), do: false

  # def anagram(word1, word2) when length(word1) == length(word2) do
  #   a = word1 |> String.codepoints |> Enum.sort
  #   b = word2 |> String.codepoints |> Enum.sort
  #   a == b
  # end

  # MyString.center(["cat", "zebra", "elephant"])
  #   cat
  #  zebra
  # elephant
  def center(word_list) do
    max_length = word_list |> Enum.map(&(String.length(&1))) |> Enum.sort |> List.last
    for word <- word_list, do: :string.pad(word, max_length, :both) |> List.to_string |> IO.puts
  end

end
