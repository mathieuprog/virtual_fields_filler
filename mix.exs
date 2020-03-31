defmodule VirtualFieldsFiller.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :virtual_fields_filler,
      elixir: "~> 1.9",
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),

      # Hex
      version: @version,
      package: package(),
      description: "Fill Ecto Schema's virtual fields recursively",

      # ExDoc
      name: "Virtual Fields Filler",
      source_url: "https://github.com/mathieuprog/virtual_fields_filler",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev},
      {:ecto, "~> 3.4", only: :test},
      {:ecto_sql, "~> 3.4", only: :test},
      {:ex_machina, "~> 2.4", only: :test},
      {:postgrex, "~> 0.15", only: :test},
      {:query_builder, "~> 0.9.0", only: :test}
    ]
  end

  defp aliases do
    [
      test: [
        "ecto.create --quiet",
        "ecto.rollback --all",
        "ecto.migrate",
        "test"
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      licenses: ["Apache 2.0"],
      maintainers: ["Mathieu Decaffmeyer"],
      links: %{"GitHub" => "https://github.com/mathieuprog/query_builder"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}"
    ]
  end
end
