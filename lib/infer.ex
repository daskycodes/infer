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
    @type matcher_fun() :: fun((binary() -> boolean()))
    @type t() :: %{matcher_type: matcher_type(), mime_type: mime_type(), extension: extension(), matcher: matcher_fun()}
  end

  # Load matchers on compilation
  @matchers Infer.Matchers.list()

  @doc """
  Takes the binary file contents as argument and returns the `t:Infer.Type.t/0` if the file matches one of the supported types. Returns `nil` otherwise.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.get(binary)
      %Infer.Type{extension: "png", matcher: &Infer.Image.is_png/1, matcher_type: :image, mime_type: "image/png"}

  """
  @spec get(binary()) :: Infer.Type.t() | nil
  def get(binary), do: Enum.find(@matchers, & &1.matcher.(binary))

  @doc """
  Same as `Infer.get/1`, but takes the file path as argument.

  ## Examples

      iex> Infer.get_from_path("test/images/sample.png")
      %Infer.Type{extension: "png", matcher: &Infer.Image.is_png/1, matcher_type: :image, mime_type: "image/png"}

  """
  @spec get_from_path(binary()) :: Infer.Type.t() | nil
  def get_from_path(path) do
    binary = File.read!(path)
    Enum.find(@matchers, & &1.matcher.(binary))
  end

  @doc """
  Takes the binary content and the file extension as arguments. Returns whether the file content is
  of the given extension.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is(binary, "png")
      true

  """
  @spec is(binary(), Infer.Type.extension()) :: boolean()
  def is(binary, extension), do: Enum.any?(@matchers, &(&1.extension == extension && &1.matcher.(binary)))

  @doc """
  Takes the binary content and the file extension as arguments. Returns whether the file content is
  of the given mime type.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_mime(binary, "image/png")
      true

  """
  @spec is_mime(binary(), Infer.Type.mime_type()) :: boolean()
  def is_mime(binary, mime_type), do: Enum.any?(@matchers, &(&1.mime_type == mime_type && &1.matcher.(binary)))

  @doc """
  Returns whether the given extension is supported.

  ## Examples

      iex> Infer.is_supported("png")
      true

  """
  @spec is_supported(Infer.Type.extension()) :: boolean()
  def is_supported(extension), do: Enum.any?(@matchers, &(&1.extension == extension))

  @doc """
  Returns whether the given mime type is supported.

  ## Examples

      iex> Infer.is_mime_supported("image/png")
      true

  """
  @spec is_mime_supported(Infer.Type.mime_type()) :: boolean()
  def is_mime_supported(mime_type), do: Enum.any?(@matchers, &(&1.mime_type == mime_type))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an application or not.

  ## Examples

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.is_app(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_app(binary)
      false

  """
  @spec is_app(binary()) :: boolean()
  def is_app(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :app && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an archive or not.

  ## Examples

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.is_archive(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_archive(binary)
      false

  """
  @spec is_archive(binary()) :: boolean()
  def is_archive(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :archive && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an archive or not.

  ## Examples

      iex> binary = File.read!("test/audio/sample.mp3")
      iex> Infer.is_audio(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_audio(binary)
      false

  """
  @spec is_audio(binary()) :: boolean()
  def is_audio(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :audio && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an book (epub or mobi) or not.

  ## Examples

      iex> binary = File.read!("test/books/sample.epub")
      iex> Infer.is_book(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_book(binary)
      false

  """
  @spec is_book(binary()) :: boolean()
  def is_book(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :book && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a document (microsoft office, open office)

  ## Examples

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.is_document(binary)
      true

      iex> binary = File.read!("test/docs/sample.pptx")
      iex> Infer.is_document(binary)
      true

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.is_document(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_document(binary)
      false

  """
  @spec is_document(binary()) :: boolean()
  def is_document(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :doc && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a font or not.

  ## Examples

      iex> binary = File.read!("test/fonts/sample.ttf")
      iex> Infer.is_font(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.is_font(binary)
      false

  """
  @spec is_font(binary()) :: boolean()
  def is_font(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :font && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is an image or not.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.is_image(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.is_image(binary)
      false

  """
  @spec is_image(binary()) :: boolean()
  def is_image(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :image && &1.matcher.(binary)))

  @doc """
  Takes the binary file contents as argument and returns whether the file is a video or not.

  ## Examples

      iex> binary = File.read!("test/videos/sample.mp4")
      iex> Infer.is_video(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.is_video(binary)
      false

  """
  @spec is_video(binary()) :: boolean()
  def is_video(binary), do: Enum.any?(@matchers, &(&1.matcher_type == :video && &1.matcher.(binary)))
end
