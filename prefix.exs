prefix = fn str -> (fn other -> "#{str} #{other}" end) end

mrs = prefix.("Mrs")
mrs.("Smith")
prefix.("Elixir").("Rocks")
