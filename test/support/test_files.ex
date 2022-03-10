defmodule TestFiles do
  @types [:app, :archives, :audio, :books, :docs, :fonts, :images, :videos, :text]
  @paths Map.new(@types, &{&1, Path.wildcard("test/#{&1}/*")})

  def list(opts \\ []) do
    requested_types =
      case List.wrap(opts[:only]) do
        [] -> @types -- List.wrap(opts[:except])
        only -> only
      end

    Stream.flat_map(@paths, fn {type, paths} ->
      if type in requested_types do
        Enum.map(paths, &{Path.basename(&1), File.read!(&1)})
      else
        []
      end
    end)
  end
end
