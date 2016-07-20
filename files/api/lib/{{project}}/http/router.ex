defmodule {{project_cap}}.HTTP.Router do
  use __MODULE__.Helper

  plug :match
  if Mix.env == :dev do
    use Plug.Debugger
    plug Plug.Logger
  end
  plug :dispatch
end
