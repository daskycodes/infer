defmodule Infer.MixProject do
  use Mix.Project

  def project do
    [
      app: :infer,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),

      # Docs
      name: "Infer",
      description: "Infer file and MIME type by checking the magic number signature",
      source_url: "https://github.com/daskycodes/infer",
      docs: [
        extras: ["README.md"],
        api_reference: false,
        main: "readme"
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
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Daniel Khaapamyaki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/daskycodes/infer"}
    ]
  end
end
