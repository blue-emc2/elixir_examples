defmodule TwoProcessToken do
  def token do
    receive do
      {sender, msg} ->
        send sender, {:ok, inspect(sender) <> " " <> msg}
        IO.puts("token")
        token()
    end
  end
end

pid = spawn(TwoProcessToken, :token, [])
IO.puts("pid")
send pid, {self(), "hoge"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self(), "fuga"}

receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts("The greeter has gone away")
end
