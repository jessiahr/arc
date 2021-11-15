defmodule Arc.Cli do
  # 1 day
  @timeout 1000 * 60 * 60 * 24
  def main(args \\ []) do
    if File.exists?(args |> hd) do
      File.read!(args |> hd)
      |> Jason.decode!()
      |> Enum.map(fn row ->
        Task.async(fn ->
          Arc.sync(row)

          receive do
            {:done, final_state} ->
              final_state
          end
        end)
      end)
      |> Task.await_many(@timeout)
      |> Enum.map(fn row ->
        IO.puts("Task:   #{row.title}")
        IO.puts("Status: #{row.logs |> Enum.count()} events\n")
      end)
    end
  end
end
