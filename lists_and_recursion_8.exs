tax_rates = [NC: 0.075, TX: 0.08]
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount:  35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00],
  [id: 126, ship_to: :TX, net_amount:  44.00],
  [id: 127, ship_to: :NC, net_amount:  25.00],
  [id: 128, ship_to: :MA, net_amount:  10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount:  50.00],
]

# とりあえずなんとなく出来たけど長い
# results = for rate <- tax_rates, order <- orders,
#   do: order ++ [total_amount: if(order[:ship_to] == :NC || order[:ship_to] == :TX, do: order[:net_amount] * (1 + elem(rate, 1)), else: order[:net_amount])]

# IO.inspect results, width: 80

# 要素ごとの配列を作ってくっつけようとしたけどダメだった
# ncs = for rate <- tax_rates, order <- orders, order[:ship_to] == :NC, do: order ++ [total_amount: order[:net_amount] * (1 + elem(rate, 1))]
# txes = for rate <- tax_rates, order <- orders, order[:ship_to] == :TX, do: order ++ [total_amount: order[:net_amount] * (1 + elem(rate, 1))]
# others = for order <- orders, order[:ship_to] != :NC && order[:ship_to] != :TX, do: order ++ [total_amount: order[:net_amount]]
# results = ncs ++ txes ++ others
# IO.inspect results, width: 80

# これがきれい
# https://github.com/pcewing/programming-elixir-exercises/blob/master/ch10/ListsAndRecursion-8/README.md

exit(:normal)
