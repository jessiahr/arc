defmodule Arc do
  use GenServer

  def sync(config) do
    GenServer.start_link(Arc, Map.put(config, "listener", self()))
  end

  @impl true
  def init(%{"from" => from, "to" => to, "listener" => listener, "title" => title})
      when is_binary(from) and is_binary(to) and is_binary(title) do
    port =
      Port.open({:spawn, "rsync -azhP --stats #{from} #{to}"}, [:binary])
      |> Port.monitor()

    {:ok, %{listener: listener, logs: [], title: title}}
  end

  @impl true
  def handle_info(m = {_port, {:data, message}}, state) do
    IO.puts(message)
    {:noreply, %{state | logs: [message | state.logs]}}
  end

  def handle_info({:DOWN, _, :port, port, :normal}, state) do
    send(state.listener, {:done, state})
    {:noreply, state}
  end
end
