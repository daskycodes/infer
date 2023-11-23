defmodule Infer do
  @moduledoc """
  A dependency free library to infer file and MIME type by checking the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming)) signature.

  An elixir adaption of the [`infer`](https://github.com/bojand/infer) rust library.
  """

  defmodule Type do
    defstruct [:matcher_type, :mime_type, :extension, :matcher]

    @type matcher_type() :: :app | :archive | :audio | :book | :image | :font | :text
    @type mime_type() :: binary()
    @type extension() :: binary()
    @type matcher_fun() :: (binary() -> boolean())
    @type t() :: %{matcher_type: matcher_type(), mime_type: mime_type(), extension: extension(), matcher: matcher_fun()}
  end

  # Load matchers on compilation
  @matchers Infer.Matchers.list()

  @doc """
  Takes the binary file contents as argument and returns the `t:Infer.Type.t/0` if the file matches one of the supported types. Returns `nil` otherwise.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.get(binary)
      %Infer.Type{extension: "png", matcher: &Infer.Image.png?/1, matcher_type: :image, mime_type: "image/png"}

  """
  @spec get(binary()) :: Infer.Type.t() | nil
  def get(binary), do: Enum.find(@matchers, & &1.matcher.(binary))

  @doc """
  Same as `Infer.get/1`, but takes the file path and byte size as argument.

  ## Examples

      iex> Infer.get_from_path("test/images/sample.png", 128)
      %Infer.Type{extension: "png", matcher: &Infer.Image.png?/1, matcher_type: :image, mime_type: "image/png"}

      iex> Infer.get_from_path("test/docs/sample.pptx")
      %Infer.Type{extension: "pptx", matcher: &Infer.Doc.pptx?/1, matcher_type: :doc, mime_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation"}

      iex> Infer.get_from_path("test/docs/unknown.path")
      nil

  """
  @spec get_from_path(binary()) :: Infer.Type.t() | nil
  def get_from_path(path, byte_size \\ 2048) do
    result = File.open(path, [:binary, :read], fn io_device ->
      case IO.binread(io_device, byte_size) do
        binary when is_binary(binary) -> Enum.find(@matchers, & &1.matcher.(binary))
        _other -> nil
      end
    end)

    case result do
      {:ok, %Infer.Type{} = type} -> type
      _other -> nil
    end
  end

  @doc """
  Takes the binary content and the file extension as arguments. Returns whether the file content is
  of the given extension.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is?(binary, "png")
      true

  """
  @spec is?(binary(), Infer.Type.extension()) :: boolean()
  def is?(binary, extension), do: Enum.any?(@matchers, &(&1.extension == extension && &1.matcher.(binary)))

  @doc """
  Takes the binary content and the file extension as arguments. Returns whether the file content is
  of the given mime type.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.mime?(binary, "image/png")
      true

  """
  @spec mime?(binary(), Infer.Type.mime_type()) :: boolean()
  def mime?(binary, mime_type), do: Enum.any?(@matchers, &(&1.mime_type == mime_type && &1.matcher.(binary)))

  @doc """
  Returns whether the given extension is supported.

  ## Examples

      iex> Infer.supported?("png")
      true

  """
  @spec supported?(Infer.Type.extension()) :: boolean()
  def supported?(extension), do: Enum.any?(@matchers, &(&1.extension == extension))

  @doc """
  Returns whether the given mime type is supported.

  ## Examples

      iex> Infer.mime_supported?("image/png")
      true

  """
  @spec mime_supported?(Infer.Type.mime_type()) :: boolean()
  def mime_supported?(mime_type), do: Enum.any?(@matchers, &(&1.mime_type == mime_type))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an application or not.

  ## Examples

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.app?(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.app?(binary)
      false

  """
  @spec app?(binary()) :: boolean()
  def app?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :app && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an archive or not.

  ## Examples

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.archive?(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.archive?(binary)
      false

  """
  @spec archive?(binary()) :: boolean()
  def archive?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :archive && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an archive or not.

  ## Examples

      iex> binary = File.read!("test/audio/sample.mp3")
      iex> Infer.audio?(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.audio?(binary)
      false

  """
  @spec audio?(binary()) :: boolean()
  def audio?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :audio && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an book (epub or mobi) or not.

  ## Examples

      iex> binary = File.read!("test/books/sample.epub")
      iex> Infer.book?(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.book?(binary)
      false

  """
  @spec book?(binary()) :: boolean()
  def book?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :book && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a document (microsoft office, open office)

  ## Examples

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.document?(binary)
      true

      iex> binary = File.read!("test/docs/sample.pptx")
      iex> Infer.document?(binary)
      true

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.document?(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.document?(binary)
      false

  """
  @spec document?(binary()) :: boolean()
  def document?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :doc && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a font or not.

  ## Examples

      iex> binary = File.read!("test/fonts/sample.ttf")
      iex> Infer.font?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.font?(binary)
      false

  """
  @spec font?(binary()) :: boolean()
  def font?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :font && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an image or not.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.image?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.image?(binary)
      false

  """
  @spec image?(binary()) :: boolean()
  def image?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :image && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a video or not.

  ## Examples

      iex> binary = File.read!("test/videos/sample.mp4")
      iex> Infer.video?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.video?(binary)
      false

  """
  @spec video?(binary()) :: boolean()
  def video?(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :video && &1.matcher.(binary)))
end
