defmodule Mix.Tasks.Shootout.Run do
  use Mix.Task

  def run(_) do
    IO.puts "=== Jiffy ==="
    Shootout.jiffy
    IO.puts "=== Mochi ==="
    Shootout.mochi
    IO.puts "=== Poison ==="
    Shootout.poison
  end
end
