defmodule Infer.Video do
  @moduledoc """
  Video type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a m4v.
  """
  @spec is_m4v(binary()) :: boolean()
  def is_m4v(<<_data::binary-size(4), 0x66, 0x74, 0x79, 0x70, 0x4D, 0x43, 0x56, _rest::binary>>), do: true
  def is_m4v(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mkv.

  ## Examples

      iex> binary = File.read!("test/videos/sample.mkv")
      iex> Infer.Video.is_mkv(binary)
      true

  """
  @spec is_mkv(binary()) :: boolean()
  def is_mkv(<<0x1A, 0x45, 0xDF, 0xA3, 0x93, 0x42, 0x82, 0x88, 0x6D, 0x61, 0x74, 0x72, 0x6F, 0x73, 0x6B, 0x61, _rest::binary>>), do: true
  def is_mkv(<<_data::binary-size(31), 0x6D, 0x61, 0x74, 0x72, 0x6F, 0x73, 0x6B, 0x61, _rest::binary>>), do: true
  def is_mkv(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a webm video.

    ## Examples

      iex> binary = File.read!("test/videos/sample.webm")
      iex> Infer.Video.is_webm(binary)
      true

  """
  @spec is_webm(binary()) :: boolean()
  def is_webm(<<0x1A, 0x45, 0xDF, 0xA3, _rest::binary>>), do: true
  def is_webm(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mov video.


    ## Examples

      iex> binary = File.read!("test/videos/sample.mov")
      iex> Infer.Video.is_mov(binary)
      true

  """
  @spec is_mov(binary()) :: boolean()
  def is_mov(<<0x0, 0x0, 0x0, 0x14, 0x66, 0x74, 0x79, 0x70, _rest::binary>>), do: true
  def is_mov(<<_data::binary-size(4), 0x6D, 0x6F, 0x6F, 0x76, _rest::binary>>), do: true
  def is_mov(<<_data::binary-size(4), 0x6D, 0x64, 0x61, 0x74, _rest::binary>>), do: true
  def is_mov(<<_data::binary-size(12), 0x6D, 0x64, 0x61, 0x74, _rest::binary>>), do: true
  def is_mov(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a AVI video.

      ## Examples

      iex> binary = File.read!("test/videos/sample.avi")
      iex> Infer.Video.is_avi(binary)
      true

  """
  @spec is_avi(binary()) :: boolean()
  def is_avi(<<0x52, 0x49, 0x46, 0x46, _data::binary-size(4), 0x41, 0x56, 0x49, _rest::binary>>), do: true
  def is_avi(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a wmv video.
  """
  @spec is_wmv(binary()) :: boolean()
  def is_wmv(<<0x30, 0x26, 0xB2, 0x75, 0x8E, 0x66, 0xCF, 0x11, 0xA6, 0xD9, _rest::binary>>), do: true
  def is_wmv(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mpeg video.


  ## Examples

      iex> binary = File.read!("test/videos/sample.mpeg")
      iex> Infer.Video.is_mpeg(binary)
      true

  """
  @spec is_mpeg(binary()) :: boolean()
  def is_mpeg(<<0x0, 0x0, 0x1, check_byte, _rest::binary>>) when check_byte >= 0xB0 and check_byte <= 0xBF, do: true
  def is_mpeg(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a flv video.
  """
  @spec is_flv(binary()) :: boolean()
  def is_flv(<<0x46, 0x4C, 0x56, 0x01, _rest::binary>>), do: true
  def is_flv(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mp4 video.

  ## Examples

      iex> binary = File.read!("test/videos/sample.mp4")
      iex> Infer.Video.is_mp4(binary)
      true

  """
  @spec is_mp4(binary()) :: boolean()
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "r", "v", "c", "1", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "d", "a", "s", "h", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "2", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "3", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "4", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "5", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "6", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "i", "s", "o", "m", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "m", "m", "p", "4", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "m", "p", "4", "1", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "m", "p", "4", "2", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "m", "p", "4", "v", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "m", "p", "7", "1", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "M", "S", "N", "V", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "A", "S", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "S", "C", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "S", "D", "C", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "S", "H", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "S", "M", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "S", "P", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "S", "S", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "X", "C", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "X", "H", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "X", "M", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "X", "P", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "N", "D", "X", "S", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "F", "4", "V", " ", _rest::binary>>), do: true
  def is_mp4(<<_data::binary-size(4), "f", "t", "y", "p", "F", "4", "P", " ", _rest::binary>>), do: true
  def is_mp4(_binary), do: false
end
