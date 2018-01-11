defmodule {{project_cap}}.Mixfile do
  use Mix.Project

  def project do
    [app: :{{project}},
     version: "0.1.0",
     elixir: "~> 1.0",
     deps: deps(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_paths: ["web"],
     elixirc_paths: ["lib", "web"]
   ]
  end

  def application do
    [mod: { {{project_cap}}, []},
     applications: [
       :cowboy,
       :logger,
     ] ++ (Mix.env == :dev && dev_applications() || [])]
  end

  defp dev_applications do
    [:exsync,]
  end

  defp deps do
    [
      {:bolero, github: "exstruct/bolero"},
      {:ecto, "~> 2.1.2"},
      {:exsync, "~> 0.2.1"},
      {:postgrex, ">= 0.0.0"},
      {:poe_api, github: "poegroup/poe-api"},
      {:sonata, github: "exstruct/sonata"},
    ]
  end
end
