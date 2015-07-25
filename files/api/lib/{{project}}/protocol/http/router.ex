defmodule {{project_cap}}.Protocol.HTTP.Router do
  use Mazurka.Protocol.HTTP.Router
  use Mazurka.Mediatype.Hyperjson.Hyperpath
  use {{project_cap}}.Dispatch

  plug :match
  if Mix.env == :dev do
    use Plug.Debugger
    plug Plug.Logger
  end
  plug :dispatch

  get     "/",                          {{project_cap}}.Resource.Root

  match   _,                            {{project_cap}}.Resource.Error.NotFound
end