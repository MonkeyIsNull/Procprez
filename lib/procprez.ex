defmodule Procprez do

  def pong() do
    hc_pid = HitCounter.start()
    receive do
      {:echo, pid, mesg} -> send(pid, mesg)
                            send(hc_pid, {:add, self()})
                            pong()
      {:ping, pid} -> send(pid, "pong")
                      send(hc_pid, {:add, self()})
                      pong()
      {_, pid, _}  -> send(pid, "Unauthorized message")
         pong()
    end
  end
end
