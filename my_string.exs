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

  def read_orders do
    # data = Stream.resource(fn -> File.open!(path) end,
    #   fn file ->
    #     case IO.read(file, :line) do
    #       data when is_binary(data) -> {IO.inspect([data]), file}
    #       _ -> {:halt, file}
    #     end
    #   end,
    #   fn file -> File.close(file) end
    # )
    #   |> Enum.to_list()
    #   |> Enum.map(&(String.trim(&1)))
    #   |> Enum.map(&(String.split(&1, ",")))
    # ↑こんな風に書いてみたけど、これでいける
    file = File.open! "sales_info.csv"
    [_header | lines] = Enum.map IO.stream(file, :line), &String.strip(&1)

    # ファイルから読み込んだものを色々加工するロジックを書いてみたけど、こんな回りくどくないはずなので途中で諦めた
    # header = List.first(data)
    #   |> Enum.map(&(String.to_atom(&1)))

    # data
    #   |> List.delete_at(0)
    #   |> Enum.map(fn(body) -> to_keyword_list(header, body) end)

    # linesには1要素、1行ごとのCSVデータが入っている
    Enum.map lines, &parse_order(&1)
  end

  def parse_order(order) do
    IO.inspect(order)
    # よく考えたら分割した結果をパターンマッチで受け取ればそれぞれの要素を取得する方法を考えなくて住むな
    [id_string, ship_to_string, net_amount_string] = String.split(order, ",")
    {id, _} = Integer.parse id_string
    ship_to = String.replace(ship_to_string, ":", "") |> String.to_atom # :OKこういうAtomはto_atomしてもうまくいかないらしいのでコロンを消しちゃう
    {net_amount, _} = Float.parse net_amount_string
    Keyword.new([{:id, id}, {:ship_to, ship_to}, {:net_amount, net_amount}])
  end

  def calculate do
    read_orders
      |> Enum.map(fn order -> apply_tax(order, tax_rates) end)
  end

  # order: キーワードリスト化された1件ごとの注文
  def apply_tax(order, tax_rates) do
    # NCとTX以外は税金0を返す判定をしている。ifがいらないすごい
    tax = Keyword.get(tax_rates, order[:ship_no], 0)
    # 引数のorderにtotal_amountを追加している
    Keyword.put(order, :total_amount, order[:net_amount] + order[:net_amount] * tax)
  end

  def tax_rates do
    [NC: 0.075, TX: 0.08]
  end

  def to_keyword_list(header, body) do
    List.zip([header, body])
      # |> Enum.into(%{})
      |> Enum.map(fn (sales) -> Map.update(sales, :id, "0", &(String.to_integer(&1))) end)
  end
end
