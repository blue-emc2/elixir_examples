fizbuz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, j -> j
end

IO.puts(fizbuz.(0, 0, 1))
IO.puts(fizbuz.(0, 1, 2))
IO.puts(fizbuz.(1, 2, 3))

fizzbuzz2 = fn n ->
  IO.puts(fizbuz.(rem(n, 3), rem(n, 5), n))
end

fizzbuzz2.(10)
fizzbuzz2.(11)
fizzbuzz2.(12)
fizzbuzz2.(13)
fizzbuzz2.(14)
fizzbuzz2.(15)
fizzbuzz2.(16)
