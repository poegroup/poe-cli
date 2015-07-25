defmodule {{project_cap}}.Supervisor do
  use Supervisor
  import Supervisor.Spec

  def start_link() do
    {:ok, _sup} = Supervisor.start_link(__MODULE__, [], name: :supervisor)
  end

  def init(_) do
    processes = []
    {:ok, { {:one_for_one, 10, 10}, processes} }
  end
end