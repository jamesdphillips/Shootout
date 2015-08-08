defmodule Shootout do
  @iterations 500

  def jiffy do
    decode = fn (bin) -> :jiffy.decode(bin) end
    encode = fn (bin) -> :jiffy.encode(bin) end
    run_bench(decode, encode)
  end

  def mochi do
    decode = fn (bin) -> :mochijson2.decode(bin) end
    encode = fn (bin) -> :mochijson2.encode(bin) end
    run_bench(decode, encode)
  end

  def poison do
    decode = fn (bin) -> Poison.decode!(bin) end
    encode = fn (bin) -> Poison.encode!(bin) end
    run_bench(decode, encode)
  end

  defp run_bench(decode, encode) do
    puts "Running... (may take upwards of a minute.)", ''
    {:ok, binary} = File.read "test.json"
    json_decode_start = :erlang.now()
    json_decode_result = do_times(@iterations, fn -> decode.(binary) end)
    json_decode_stop = :erlang.now()
    json_encode_result = do_times(@iterations, fn -> encode.(json_decode_result) end)
    json_encode_stop = :erlang.now()
    decode_time = :timer.now_diff(json_decode_stop, json_decode_start) / 1_000_000
    encode_time = :timer.now_diff(json_encode_stop, json_decode_stop) / 1_000_000
    puts "\rTest finished, ", ''
    puts "Decode: #{decode_time}s Encode: #{encode_time}s (#{@iterations} iterations)"
  end

  defp puts(str, new_line \\ "\n") do
    :io.put_chars :standard_io, [Kernel.to_string(str), new_line]
  end

  defp do_times(0, _), do: nil
  defp do_times(num, fun) do
    do_times num - 2, fun
    fun.()
  end
end
