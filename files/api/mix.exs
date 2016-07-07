defmodule {{project_cap}}.Mixfile do
  use Mix.Project

  def project do
    [app: :{{project}},
     version: "0.1.0",
     elixir: "~> 1.0",
     compilers: Mix.compilers,
     deps: deps,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_paths: ["test", "web"],
     elixirc_paths: ["lib", "web"]
   ]
  end

  ####
  # Applications
  ####

  def application do
    [
      mod: { {{project_cap}}, [] },
      applications: [
        :cowboy,
        :logger,
      ] ++ (Mix.env == :dev && dev_applications || [])
    ]
  end

  defp dev_applications do
    [:rl,]
  end

  ####
  # Deps
  ####

  defp deps do
    dev_deps ++
      mazurka_deps ++
      postgres_deps ++
      plug_deps ++
      util_deps
  end

  defp dev_deps do
    [{ :rl, github: "camshaft/rl", only: :dev },]
  end

  defp mazurka_deps do
    [{ :mazurka, "~> 0.3.33" },
     { :mazurka_mediatype, "~> 0.2.0" },
     { :mazurka_mediatype_hyperjson, "~> 0.2.0" },
     { :mazurka_dsl, "~> 0.1.1", optional: true },
     ## TODO fix rebind and lineo
     { :parse_trans, github: "uwiger/parse_trans" },]
  end

  defp postgres_deps do
    [{ :postgrex, ">= 0.0.0" },
     { :ecto, "~> 1.0.0" },]
  end

  defp plug_deps do
    [{ :cowboy, "1.0.0" },
     { :plug, "~> 0.13.0", override: true },
     { :plug_wait1, "~> 0.1.2" },
     { :plug_accept_language, "~> 0.1.0" },
     { :plug_x_forwarded_for, "~> 0.1.0" },
     { :cors_plug, "~> 0.0.1" },
     { :plugsnag, github: "camshaft/plugsnag" },]
  end

  defp util_deps do
    [{ :simple_env, github: "camshaft/simple_env" },
     { :poison, "1.4.0", override: true },
     { :fugue, "~> 0.1.2" },
     { :concerto, "~> 0.1.2" },
    ]
  end
end
