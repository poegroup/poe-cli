defmodule {{project_cap}}.Dispatch do
  use Mazurka.Dispatch
  alias {{project_cap}}.Service

  service Greeting.world/0, Service.Greeting.world
end