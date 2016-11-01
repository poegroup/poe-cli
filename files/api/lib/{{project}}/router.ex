defmodule {{project_cap}}.Router do
  use Concerto, [root: "#{System.cwd!}/web",
                 ext: ".ex",
                 module_prefix: {{project_cap}}.Resource]
  use Concerto.Plug.Mazurka

  plug :match
  plug PlugXForwardedProto

  if Mix.env == :dev do
    use Plug.Debugger
    plug Plug.Logger
  end

  plug Plug.Parsers, parsers: [Plug.Parsers.Wait1,
                               Plug.Parsers.JSON,
                               Plug.Parsers.URLENCODED],
                     json_decoder: Poison

  plug :dispatch
end
