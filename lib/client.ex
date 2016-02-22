defmodule Client do
  
  def send_messages() do
    client = self()
    pong = spawn(Procprez, :start, [])
    send(pong, {:echo, client, "olleh"})
    send(pong, {:ping, client})
    send(pong, {:query_db, client, "select * from foo"})
    send(pong, {:count, client})
    check_messages(pong)
  end

  def check_messages(pong) do
    receive do
       {:count, pid} -> send(pong, {:count, self()}) 
       mesg -> IO.inspect mesg
    end
    check_messages(pong)
  end

  def kick_start() do
    spawn(fn -> send_messages() end)
  end
end

