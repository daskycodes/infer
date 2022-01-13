defmodule Infer.Archive do
  @moduledoc """
  Archive type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  defdelegate epub?(binary), to: Infer.Book

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a zip archive.

  See: https://en.wikipedia.org/wiki/List_of_file_signatures

  ## Examples

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.Archive.zip?(binary)
      true

  """
  @spec zip?(binary()) :: boolean()
  def zip?(<<0x50, 0x4B, 0x3, 0x4, _rest::binary>>), do: true
  def zip?(<<0x50, 0x4B, 0x5, 0x6, _rest::binary>>), do: true
  def zip?(<<0x50, 0x4B, 0x7, 0x8, _rest::binary>>), do: true
  def zip?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a tar archive.
  """
  @spec tar?(binary()) :: boolean()
  def tar?(<<_data::binary-size(257), 0x75, 0x73, 0x74, 0x61, 0x72, _rest::binary>>), do: true
  def tar?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a rar archive.
  """
  @spec rar?(binary()) :: boolean()
  def rar?(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x0, _rest::binary>>), do: true
  def rar?(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x1, _rest::binary>>), do: true
  def rar?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a gzip archive.
  """
  @spec gz?(binary()) :: boolean()
  def gz?(<<0x1F, 0x8B, 0x8, _rest::binary>>), do: true
  def gz?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a bzip archive.
  """
  @spec bz2?(binary()) :: boolean()
  def bz2?(<<0x42, 0x5A, 0x68, _rest::binary>>), do: true
  def bz2?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a 7z archive.
  """
  @spec sevenz?(binary()) :: boolean()
  def sevenz?(<<0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C, _rest::binary>>), do: true
  def sevenz?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a pdf.

  ## Examples

      iex> binary = File.read!("test/archives/sample.pdf")
      iex> Infer.Archive.pdf?(binary)
      true

  """
  @spec pdf?(binary()) :: boolean()
  def pdf?(<<0x25, 0x50, 0x44, 0x46, _rest::binary>>), do: true
  def pdf?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a swf.
  """
  @spec swf?(binary()) :: boolean()
  def swf?(<<0x43, 0x57, 0x53, _rest::binary>>), do: true
  def swf?(<<0x46, 0x57, 0x53, _rest::binary>>), do: true
  def swf?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a rtf.
  """
  @spec rtf?(binary()) :: boolean()
  def rtf?(<<0x7B, 0x5C, 0x72, 0x74, 0x66, _rest::binary>>), do: true
  def rtf?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Nintendo NES ROM.
  """
  @spec nes?(binary()) :: boolean()
  def nes?(<<0x4E, 0x45, 0x53, 0x1A, _rest::binary>>), do: true
  def nes?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Google Chrome Extension.
  """
  @spec crx?(binary()) :: boolean()
  def crx?(<<0x43, 0x72, 0x32, 0x34, _rest::binary>>), do: true
  def crx?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a CAB.
  """
  @spec cab?(binary()) :: boolean()
  def cab?(<<0x4D, 0x53, 0x43, 0x46, _rest::binary>>), do: true
  def cab?(<<0x49, 0x53, 0x63, 0x28, _rest::binary>>), do: true
  def cab?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a eot octet stream.
  """
  @spec eot?(binary()) :: boolean()
  def eot?(<<_header::binary-size(8), 0x01, 0x00, 0x00, _data::binary-size(24), 0x4C, 0x50, _rest::binary>>), do: true
  def eot?(<<_header::binary-size(8), 0x02, 0x00, 0x02, _data::binary-size(24), 0x4C, 0x50, _rest::binary>>), do: true
  def eot?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a postscript.
  """
  @spec ps?(binary()) :: boolean()
  def ps?(<<0x25, 0x21, _rest::binary>>), do: true
  def ps?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a xz archive.
  """
  @spec xz?(binary()) :: boolean()
  def xz?(<<0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x00, _rest::binary>>), do: true
  def xz?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a sqlite3 database.


  ## Examples

      iex> binary = File.read!("test/archives/sample.db")
      iex> Infer.Archive.sqlite?(binary)
      true

  """
  @spec sqlite?(binary()) :: boolean()
  def sqlite?(<<0x53, 0x51, 0x4C, 0x69, _rest::binary>>), do: true
  def sqlite?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a deb archive.
  """
  @spec deb?(binary()) :: boolean()
  def deb?(
        <<0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, 0x0A, 0x64, 0x65, 0x62, 0x69, 0x61, 0x6E, 0x2D, 0x62, 0x69, 0x6E, 0x61, 0x72, 0x79,
          _rest::binary>>
      ),
      do: true

  def deb?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a ar archive.
  """
  @spec ar?(binary()) :: boolean()
  def ar?(<<0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, _rest::binary>>), do: true
  def ar?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a z archive.
  """
  @spec z?(binary()) :: boolean()
  def z?(<<0x1F, 0xA0, _rest::binary>>), do: true
  def z?(<<0x1F, 0x9D, _rest::binary>>), do: true
  def z?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a lzip archive.
  """
  @spec lz?(binary()) :: boolean()
  def lz?(<<0x4C, 0x5A, 0x49, 0x50, _rest::binary>>), do: true
  def lz?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a RPM.
  """
  @spec rpm?(binary()) :: boolean()
  def rpm?(<<0xED, 0xAB, 0xEE, 0xDB, _rest::binary>> = binary) when byte_size(binary) < 96, do: true
  def rpm?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a dcm archive.
  """
  @spec dcm?(binary()) :: boolean()
  def dcm?(<<_data::binary-size(128), 0x44, 0x49, 0x43, 0x4D, _rest::binary>>), do: true
  def dcm?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Zstd archive.

    ## Examples

      iex> binary = File.read!("test/archives/sample.tar.zst")
      iex> Infer.Archive.zst?(binary)
      true

  """
  @spec zst?(binary()) :: boolean()
  def zst?(<<0x28, 0xB5, 0x2F, 0xFD, _rest::binary>>), do: true
  def zst?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a MSI windows installer archive.
  """
  @spec msi?(binary()) :: boolean()
  def msi?(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>>), do: true
  def msi?(_binary), do: false
end
