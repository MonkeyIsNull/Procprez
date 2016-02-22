defmodule Procprez do

  def pong() do
    receive do
      {:echo, pid, mesg} -> send(pid, mesg)
                            pong()
      {:ping, pid} -> send(pid, "pong")
                      pong()
      _ -> IO.puts "Unauthorized message"
         pong()
    end
  end
end
