defmodule {{project_cap}}.Mixfile do
  use Mix.Project

  def project do
    [app: :{{project}},
     version: "0.1.0",
     elixir: "~> 1.0",
     deps: deps,
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
     ] ++ (Mix.env == :dev && dev_applications || [])]
  end

  defp dev_applications do
    [:rl,]
  end

  defp deps do
    [{:concerto, "~> 0.1.2"},
     {:cowboy, "1.0.0" },
     {:fugue, "~> 0.1.2"},
     {:mazurka, "~> 1.0.0"},
     {:plug, "~> 0.13.0", override: true},
     {:plug_wait1, "~> 0.1.2"},
     {:poison, "2.2.0", override: true},
     {:rl, github: "camshaft/rl", only: :dev},]
  end
end
