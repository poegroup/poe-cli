defmodule {{project_cap}}.Protocol.HTTP.Router do
  use __MODULE__.Helper
  use Mazurka.Mediatype.Hyperjson.Hyperpath
  use {{project_cap}}.Dispatch, [
    link_transform: :link_transform
  ]

  plug :match
  if Mix.env == :dev do
    use Plug.Debugger
    plug Plug.Logger
  end
  plug :dispatch

  def link_transform(link, _) do
    link
  end
end