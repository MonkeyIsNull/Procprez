defmodule Procprez do

  def pong(hc_pid) do
    receive do
      {:echo, pid, mesg} -> send(pid, mesg)
                            send(hc_pid, {:add, self()})
                            pong(hc_pid)
      {:ping, pid} -> send(pid, "pong")
                      send(hc_pid, {:add, self()})
                      pong(hc_pid)
      {:count, pid} ->  send(hc_pid, {:count, self()})
                        pong(hc_pid)
      {:total_count, count} -> IO.puts "Count: #{count}"
                               pong(hc_pid)
      {_, pid, _}  -> send(pid, "Unauthorized message")
                      pong(hc_pid)
    end
  end

  def start() do
    hc = HitCounter.start()
    pong(hc)
  end
end
