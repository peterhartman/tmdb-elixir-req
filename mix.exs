defmodule TmdbElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :tmdb_elixir_req,
      version: "0.1.0",
      elixir: "~> 1.18",
      usage_rules: usage_rules(),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:poison, "~> 6.0"},
      {:usage_rules, "~> 1.0", only: [:dev]},
      {:igniter, "~> 0.6", only: [:dev, :test]},
      {:req, "~> 0.5.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "An Elixir wrapper for using the TMDb (The Movie Database) API."
  end

  defp package() do
    [
      files: ~w(lib mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/peterhartman/tmdb-elixir-req"}
    ]
  end

  defp usage_rules do
        # Example for those using claude.
        [
          file: "CLAUDE.md",
          # rules to include directly in CLAUDE.md
          usage_rules: ["usage_rules:all"],
          skills: [
            location: ".claude/skills",
            # build skills that combine multiple usage rules
            build: [
              "ash-framework": [
                # The description tells people how to use this skill.
                description: "Use this skill working with Ash Framework or any of its extensions. Always consult this when making any domain changes, features or fixes.",
                # Include all Ash dependencies
                usage_rules: [:ash, ~r/^ash_/]
              ],
              "phoenix-framework": [
                description: "Use this skill working with Phoenix Framework. Consult this when working with the web layer, controllers, views, liveviews etc.",
                # Include all Phoenix dependencies
                usage_rules: [:phoenix, ~r/^phoenix_/]
              ]
            ]
          ]
        ]
      end
end
