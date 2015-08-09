defmodule Shootout do
  @iterations 500

  def jiffy do
    {t1, t2} = run_bench "test.json", &:jiffy.decode/1, &:jiffy.encode/1
    print_res "Jiffy", t1, t2
  end

  def mochi do
    {t1, t2} = run_bench "test.json", &:mochijson2.decode/1, &:mochijson2.encode/1
    print_res "Mochi", t1, t2
  end

  def poison do
    {t1, t2} = run_bench "test.json", &Poison.decode!/1, &Poison.encode!/1
    print_res "Poison", t1, t2
  end

  def msgpax do
    {t1, t2} = run_bench "test.msgpack", &Msgpax.unpack!/1, &Msgpax.pack!/1
    print_res "Msgpax", t1, t2
  end

  def message_pack do
    {t1, t2} = run_bench "test.msgpack", &MessagePack.unpack!/1, &MessagePack.pack!/1
    print_res "MessagePack", t1, t2
  end

  def msgpack do
    decode = fn (bin) -> :msgpack.unpack(bin, format: :map) |> elem(1) end
    {t1, t2} = run_bench "test.msgpack", decode, &:msgpack.pack(&1, format: :map)
    print_res "Msgpack (Official)", t1, t2
  end

  defp run_bench(file, decode, encode) do
    puts "Running bench... (may take upwards of a minute.)"
    {:ok, binary} = File.read file
    json_decode_start = :erlang.now()
    json_decode_result = do_times(@iterations, fn -> decode.(binary) end)
    json_decode_stop = :erlang.now()
    json_encode_result = do_times(@iterations, fn -> encode.(json_decode_result) end)
    json_encode_stop = :erlang.now()
    decode_time = :timer.now_diff(json_decode_stop, json_decode_start) / 1_000_000
    encode_time = :timer.now_diff(json_encode_stop, json_decode_stop) / 1_000_000
    {decode_time, encode_time}
  end

  defp print_res(type, t1, t2) do
    puts "\r#{type}: Decode -> #{t1}s Encode -> #{t2}s (#{@iterations} iterations)\n"
  end

  defp puts(str) do
    :io.put_chars :standard_io, [Kernel.to_string(str)]
  end

  defp do_times(0, _), do: nil
  defp do_times(num, fun) do
    do_times num - 2, fun
    fun.()
  end
end
