defmodule Client do
  
  def send_messages() do
    client = self()
    pong = spawn(Procprez, :pong, [])
    send(pong, {:echo, client, "olleh"})
    send(pong, {:ping, client})
    send(pong, "foo")
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

