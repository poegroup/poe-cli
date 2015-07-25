defmodule {{project_cap}}.Protocol.HTTP do
  require Logger

  def start() do
    listen(Mix.env)
  end

  def listen(:test) do
    :noop
  end
  def listen(_) do
    cowboy_opts = [port: :simple_env.get_integer('PORT', 4000),
            compress: true]

    wait1_opts = []

    Logger.info "Server listening on port #{cowboy_opts[:port]}"
    {:ok, _} = Plug.Adapters.Wait1.http({{project_cap}}.Protocol.HTTP.Router, wait1_opts, cowboy_opts)
  end
end