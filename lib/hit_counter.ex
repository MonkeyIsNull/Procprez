defmodule HitCounter do

  def loop(count) do
    receive do
      {:add, _pid} ->
            loop(count + 1)
      {:count, pid} -> send(pid, {:total_count, count})
                       loop(count)
    end
  end

  def start() do
    spawn(fn -> loop(0) end)
  end
end

