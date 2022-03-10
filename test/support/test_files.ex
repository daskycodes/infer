defmodule TestFiles do
  @types [:app, :archives, :audio, :books, :docs, :fonts, :images, :videos, :text]

  @files (for type <- @types,
              path <- Path.wildcard("test/#{type}/*") do
            @external_resource Path.relative_to_cwd(path)

            {type, {Path.basename(path), File.read!(path)}}
          end)
         |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
         |> Map.new()

  def list(opts \\ [])
  def list(only: only), do: Map.fetch!(@files, only)

  def list(opts) do
    except = List.wrap(opts[:except])

    Map.take(@files, @types -- except)
    |> Map.values()
    |> List.flatten()
  end
end
