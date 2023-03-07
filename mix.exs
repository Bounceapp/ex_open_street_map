defmodule ExOpenStreetMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_open_street_map,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "An Elixir wrapper for Open Street Map Nominatim's API.",
      package: package(),
      deps: deps(),
      # Docs
      name: "ex_open_street_map",
      source_url: "https://github.com/Bounceapp/ex_open_street_map",
      homepage_url: "https://github.com/Bounceapp/ex_open_street_map",
      docs: [
        # The main page in the docs
        main: "ex_open_street_map",
        extras: ["README.md"]
      ]
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
      {:httpoison, "~> 1.8"},
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Bounceapp/ex_open_street_map"}
    ]
  end
end
