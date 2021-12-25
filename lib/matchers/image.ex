defmodule Infer.Image do
  @moduledoc """
  Image type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a jpeg.

  ## Examples

      iex> binary = File.read!("test/images/sample.jpg")
      iex> Infer.Image.is_jpeg(binary)
      true

      iex> binary = File.read!("test/images/sample.jp2")
      iex> Infer.Image.is_jpeg(binary)
      false

  """
  @spec is_jpeg(binary()) :: boolean()
  def is_jpeg(<<0xFF, 0xD8, 0xFF>> <> _), do: true
  def is_jpeg(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a jpeg2000.

  ## Examples

      iex> binary = File.read!("test/images/sample.jp2")
      iex> Infer.Image.is_jpeg2000(binary)
      true

      iex> binary = File.read!("test/images/sample.jpg")
      iex> Infer.Image.is_jpeg2000(binary)
      false

  """
  @spec is_jpeg2000(binary()) :: boolean()
  def is_jpeg2000(<<0x0, 0x0, 0x0, 0xC, 0x6A, 0x50, 0x20, 0x20, 0xD, 0xA, 0x87, 0xA, 0x0, _rest::binary>>), do: true
  def is_jpeg2000(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a png.

  ## Examples

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.Image.is_png(binary)
      true

      iex> binary = File.read!("test/images/sample.jpg")
      iex> Infer.Image.is_png(binary)
      false

  """
  @spec is_png(binary()) :: boolean()
  def is_png(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>>), do: true
  def is_png(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a gif.

  ## Examples

      iex> binary = File.read!("test/images/sample.gif")
      iex> Infer.Image.is_gif(binary)
      true

      iex> binary = File.read!("test/images/sample.jpg")
      iex> Infer.Image.is_gif(binary)
      false

  """
  @spec is_gif(binary()) :: boolean()
  def is_gif(<<0x47, 0x49, 0x46, _rest::binary>>), do: true
  def is_gif(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a webp.

  ## Examples

      iex> binary = File.read!("test/images/sample.webp")
      iex> Infer.Image.is_webp(binary)
      true

      iex> binary = File.read!("test/images/sample.gif")
      iex> Infer.Image.is_webp(binary)
      false

  """
  @spec is_webp(binary()) :: boolean()
  def is_webp(<<_head::binary-size(8), 0x57, 0x45, 0x42, 0x50, _rest::binary>>), do: true
  def is_webp(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a cr2.

  ## Examples

      iex> binary = File.read!("test/images/sample.cr2")
      iex> Infer.Image.is_cr2(binary)
      true

      iex> binary = File.read!("test/images/sample.tiff")
      iex> Infer.Image.is_cr2(binary)
      false

  """
  @spec is_cr2(binary()) :: boolean()
  def is_cr2(<<0x49, 0x49, 0x2A, 0x0, _data::binary-size(4), 0x43, 0x52, 0x02, _rest::binary>>), do: true
  def is_cr2(<<0x4D, 0x4D, 0x0, 0x2A, _data::binary-size(4), 0x43, 0x52, 0x02, _rest::binary>>), do: true
  def is_cr2(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a tiff.

  ## Examples

      iex> binary = File.read!("test/images/sample.tiff")
      iex> Infer.Image.is_tiff(binary)
      true

      iex> binary = File.read!("test/images/sample.cr2")
      iex> Infer.Image.is_tiff(binary)
      false

  """
  @spec is_tiff(binary()) :: boolean()
  def is_tiff(<<0x49, 0x49, 0x2A, 0x0, _data::binary-size(4), i_8, i_9, _rest::binary>> = binary) when i_8 != <<0x43>> and i_9 != <<0x52>>,
    do: !is_cr2(binary)

  def is_tiff(<<0x4D, 0x4D, 0x0, 0x2A, _data::binary-size(4), i_8, i_9, _rest::binary>> = binary) when i_8 != <<0x43>> and i_9 != <<0x52>>,
    do: !is_cr2(binary)

  def is_tiff(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a bmp.

  ## Examples

      iex> binary = File.read!("test/images/sample.bmp")
      iex> Infer.Image.is_bmp(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.Image.is_bmp(binary)
      false

  """
  @spec is_bmp(binary()) :: boolean()
  def is_bmp(<<0x42, 0x4D, _rest::binary>>), do: true
  def is_bmp(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a jxr.

  ## Examples

      iex> binary = File.read!("test/images/sample.jxr")
      iex> Infer.Image.is_jxr(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.Image.is_jxr(binary)
      false

  """
  @spec is_jxr(binary()) :: boolean()
  def is_jxr(<<0x49, 0x49, 0xBC, _rest::binary>>), do: true
  def is_jxr(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a psd.

  ## Examples

      iex> binary = File.read!("test/images/sample.psd")
      iex> Infer.Image.is_psd(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.Image.is_psd(binary)
      false

  """
  @spec is_psd(binary()) :: boolean()
  def is_psd(<<0x38, 0x42, 0x50, 0x53, _rest::binary>>), do: true
  def is_psd(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a ico.

  ## Examples

      iex> binary = File.read!("test/images/sample.ico")
      iex> Infer.Image.is_ico(binary)
      true

      iex> binary = File.read!("test/images/sample.png")
      iex> Infer.Image.is_ico(binary)
      false

  """
  @spec is_ico(binary()) :: boolean()
  def is_ico(<<0x00, 0x00, 0x01, 0x00, _rest::binary>>), do: true
  def is_ico(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a heif.

  ## Examples

      iex> binary = File.read!("test/images/sample.heif")
      iex> Infer.Image.is_heif(binary)
      true

      iex> binary = File.read!("test/images/sample.avif")
      iex> Infer.Image.is_heif(binary)
      false

  """
  @spec is_heif(binary()) :: boolean()
  def is_heif(<<ftyp_length::binary-size(4), "ftyp", _::binary>> = binary) when bit_size(ftyp_length) >= 16 do
    case get_ftyp(binary) do
      {"heic", _minor, _compatbile} -> true
      {major, _minor, compatible} when major in ["mif1", "msf1"] -> 'heic' in compatible
      _ -> false
    end
  end

  def is_heif(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a avif.

  ## Examples

      iex> binary = File.read!("test/images/sample.avif")
      iex> Infer.Image.is_avif(binary)
      true

      iex> binary = File.read!("test/images/sample.heif")
      iex> Infer.Image.is_avif(binary)
      false

  """
  @spec is_avif(binary()) :: boolean()
  def is_avif(<<ftyp_length::binary-size(4), "ftyp", _::binary>> = binary) when bit_size(ftyp_length) >= 16 do
    case get_ftyp(binary) do
      {major, _minor, _compatbile} when major in ["avif", "avis"] -> true
      {_major, _minor, compatible} -> 'avif' in compatible || 'avis' in compatible
      _ -> false
    end
  end

  def is_avif(_binary), do: false

  defp get_ftyp(<<ftyp_length::binary-size(4), "ftyp", major::binary-size(4), minor::binary-size(4), rest::binary>>) do
    compatible =
      rest
      |> :binary.bin_to_list()
      |> Stream.chunk_every(4)
      |> Enum.take(Enum.max([Integer.floor_div(bit_size(ftyp_length), 4) - 4, 0]))

    {major, minor, compatible}
  end
end
