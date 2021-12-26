defmodule Infer.Archive do
  @moduledoc """
  Archive type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  defdelegate is_epub(binary), to: Infer.Book

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a zip archive.

  See: https://en.wikipedia.org/wiki/List_of_file_signatures

  ## Examples

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.Archive.is_zip(binary)
      true

  """
  @spec is_zip(binary()) :: boolean()
  def is_zip(<<0x50, 0x4B, 0x3, 0x4, _rest::binary>>), do: true
  def is_zip(<<0x50, 0x4B, 0x5, 0x6, _rest::binary>>), do: true
  def is_zip(<<0x50, 0x4B, 0x7, 0x8, _rest::binary>>), do: true
  def is_zip(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a tar archive.
  """
  @spec is_tar(binary()) :: boolean()
  def is_tar(<<_data::binary-size(257), 0x75, 0x73, 0x74, 0x61, 0x72, _rest::binary>>), do: true
  def is_tar(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a rar archive.
  """
  @spec is_rar(binary()) :: boolean()
  def is_rar(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x0, _rest::binary>>), do: true
  def is_rar(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x1, _rest::binary>>), do: true
  def is_rar(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a gzip archive.
  """
  @spec is_gz(binary()) :: boolean()
  def is_gz(<<0x1F, 0x8B, 0x8, _rest::binary>>), do: true
  def is_gz(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a bzip archive.
  """
  @spec is_bz2(binary()) :: boolean()
  def is_bz2(<<0x42, 0x5A, 0x68, _rest::binary>>), do: true
  def is_bz2(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a 7z archive.
  """
  @spec is_7z(binary()) :: boolean()
  def is_7z(<<0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C, _rest::binary>>), do: true
  def is_7z(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a pdf.

  ## Examples

      iex> binary = File.read!("test/archives/sample.pdf")
      iex> Infer.Archive.is_pdf(binary)
      true

  """
  @spec is_pdf(binary()) :: boolean()
  def is_pdf(<<0x25, 0x50, 0x44, 0x46, _rest::binary>>), do: true
  def is_pdf(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a swf.
  """
  @spec is_swf(binary()) :: boolean()
  def is_swf(<<0x43, 0x57, 0x53, _rest::binary>>), do: true
  def is_swf(<<0x46, 0x57, 0x53, _rest::binary>>), do: true
  def is_swf(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a rtf.
  """
  @spec is_rtf(binary()) :: boolean()
  def is_rtf(<<0x7B, 0x5C, 0x72, 0x74, 0x66, _rest::binary>>), do: true
  def is_rtf(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Nintendo NES ROM.
  """
  @spec is_nes(binary()) :: boolean()
  def is_nes(<<0x4E, 0x45, 0x53, 0x1A, _rest::binary>>), do: true
  def is_nes(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Google Chrome Extension.
  """
  @spec is_crx(binary()) :: boolean()
  def is_crx(<<0x43, 0x72, 0x32, 0x34, _rest::binary>>), do: true
  def is_crx(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a CAB.
  """
  @spec is_cab(binary()) :: boolean()
  def is_cab(<<0x4D, 0x53, 0x43, 0x46, _rest::binary>>), do: true
  def is_cab(<<0x49, 0x53, 0x63, 0x28, _rest::binary>>), do: true
  def is_cab(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a eot octet stream.
  """
  @spec is_eot(binary()) :: boolean()
  def is_eot(<<_header::binary-size(8), 0x01, 0x00, 0x00, _data::binary-size(24), 0x4C, 0x50, _rest::binary>>), do: true
  def is_eot(<<_header::binary-size(8), 0x02, 0x00, 0x02, _data::binary-size(24), 0x4C, 0x50, _rest::binary>>), do: true
  def is_eot(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a postscript.
  """
  @spec is_ps(binary()) :: boolean()
  def is_ps(<<0x25, 0x21, _rest::binary>>), do: true
  def is_ps(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a xz archive.
  """
  @spec is_xz(binary()) :: boolean()
  def is_xz(<<0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x00, _rest::binary>>), do: true
  def is_xz(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a sqlite3 database.


  ## Examples

      iex> binary = File.read!("test/archives/sample.db")
      iex> Infer.Archive.is_sqlite(binary)
      true

  """
  @spec is_sqlite(binary()) :: boolean()
  def is_sqlite(<<0x53, 0x51, 0x4C, 0x69, _rest::binary>>), do: true
  def is_sqlite(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a deb archive.
  """
  @spec is_deb(binary()) :: boolean()
  def is_deb(
        <<0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, 0x0A, 0x64, 0x65, 0x62, 0x69, 0x61, 0x6E, 0x2D, 0x62, 0x69, 0x6E, 0x61, 0x72, 0x79,
          _rest::binary>>
      ),
      do: true

  def is_deb(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a ar archive.
  """
  @spec is_ar(binary()) :: boolean()
  def is_ar(<<0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, _rest::binary>>), do: true
  def is_ar(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a z archive.
  """
  @spec is_z(binary()) :: boolean()
  def is_z(<<0x1F, 0xA0, _rest::binary>>), do: true
  def is_z(<<0x1F, 0x9D, _rest::binary>>), do: true
  def is_z(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a lzip archive.
  """
  @spec is_lz(binary()) :: boolean()
  def is_lz(<<0x4C, 0x5A, 0x49, 0x50, _rest::binary>>), do: true
  def is_lz(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a RPM.
  """
  @spec is_rpm(binary()) :: boolean()
  def is_rpm(<<0xED, 0xAB, 0xEE, 0xDB, _rest::binary>> = binary) when byte_size(binary) < 96, do: true
  def is_rpm(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a dcm archive.
  """
  @spec is_dcm(binary()) :: boolean()
  def is_dcm(<<_data::binary-size(128), 0x44, 0x49, 0x43, 0x4D, _rest::binary>>), do: true
  def is_dcm(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Zstd archive.

    ## Examples

      iex> binary = File.read!("test/archives/sample.tar.zst")
      iex> Infer.Archive.is_zst(binary)
      true

  """
  @spec is_zst(binary()) :: boolean()
  def is_zst(<<0x28, 0xB5, 0x2F, 0xFD, _rest::binary>>), do: true
  def is_zst(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a MSI windows installer archive.
  """
  @spec is_msi(binary()) :: boolean()
  def is_msi(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>>), do: true
  def is_msi(_binary), do: false
end
