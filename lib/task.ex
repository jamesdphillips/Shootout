defmodule Mix.Tasks.Shootout.Run do
  use Mix.Task

  def run(_) do
    [
      Task.async(&mochi/0),
      Task.async(&poison/0),
      Task.async(&jiffy/0)
    ] |> Enum.map(&Task.await(&1, 60_000))
  end

  def mochi do
    IO.puts "=== Mochi ==="
    Shootout.mochi
  end

  defp jiffy do
    IO.puts "=== Jiffy ==="
    Shootout.jiffy
  end

  defp poison do
    IO.puts "=== Poison ==="
    Shootout.poison
  end
end
