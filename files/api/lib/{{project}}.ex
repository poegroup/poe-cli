defmodule {{project_cap}} do
  use Application
  require Logger

  def start(_type, _args) do
    if Mix.env == :dev do
      dev()
    end
    {{project_cap}}.HTTP.start()
    {{project_cap}}.Supervisor.start_link()
  end

  def dev do
    ExSync.start()
  end
end
