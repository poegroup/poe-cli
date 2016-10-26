defmodule {{project_cap}}.Router do
  use Concerto, [root: "#{System.cwd!}/web",
                 ext: ".ex",
                 module_prefix: {{project_cap}}.Resource]
  use Concerto.Plug.Mazurka

  plug :match
  if Mix.env == :dev do
    use Plug.Debugger
    plug Plug.Logger
  end
  plug :dispatch
end
