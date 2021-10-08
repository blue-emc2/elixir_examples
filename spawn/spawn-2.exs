defmodule Spawn2 do
  def greed do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

pid = spawn(Spawn2, :greed, [])
send pid, {self(), "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
  {:ok, message} ->
    IO.puts message
end
