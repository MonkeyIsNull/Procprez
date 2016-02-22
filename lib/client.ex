defmodule Client do
  
  def send_messages() do
    client = self()
    pong = spawn(Procprez, :start, [])
    send(pong, {:echo, client, "olleh"})
    send(pong, {:ping, client})
    send(pong, {:query_db, client, "select * from foo"})
    check_messages()
  end

  def check_messages() do
    receive do
       mesg -> IO.inspect mesg
    end
    check_messages()
  end

  def kick_start() do
    spawn(fn -> send_messages() end)
  end
end

