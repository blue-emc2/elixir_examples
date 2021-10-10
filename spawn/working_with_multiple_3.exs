defmodule WorkingWithMultiple3 do
  import :timer, only: [sleep: 1]

  def greed do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}"}
        exit(:boom)
    end
  end

  def run do
    pid = spawn_link(WorkingWithMultiple3, :greed, [])
    send pid, {self(), "World!"}
    sleep(500)

    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
    after 1000 ->
      IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

WorkingWithMultiple3.run()
