defmodule Infer.Audio do
  @moduledoc """
  Audio type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a midi.
  """
  @spec midi?(binary()) :: boolean()
  def midi?(<<0x4D, 0x54, 0x68, 0x64, _rest::binary>>), do: true
  def midi?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mp3.

  ## Examples

      iex> binary = File.read!("test/audio/sample.mp3")
      iex> Infer.Audio.mp3?(binary)
      true

  """
  @spec mp3?(binary()) :: boolean()
  def mp3?(<<0x49, 0x44, 0x33, _rest::binary>>), do: true
  def mp3?(<<0xFF, 0xFB, _rest::binary>>), do: true
  def mp3?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a m4a.
  """
  @spec m4a?(binary()) :: boolean()
  def m4a?(<<_data::binary-size(4), 0x66, 0x74, 0x79, 0x70, 0x4D, 0x3F, 0x41, _rest::binary>>), do: true
  def m4a?(<<0x4D, 0x34, 0x41, 0x20, _rest::binary>>), do: true
  def m4a?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a ogg.
  """
  @spec ogg?(binary()) :: boolean()
  def ogg?(<<0x4F, 0x67, 0x67, 0x53, _rest::binary>>), do: true
  def ogg?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a flac.
  """
  @spec flac?(binary()) :: boolean()
  def flac?(<<0x66, 0x4C, 0x61, 0x43, _rest::binary>>), do: true
  def flac?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a wav.
  """
  @spec wav?(binary()) :: boolean()
  def wav?(<<0x52, 0x49, 0x46, 0x46, _data::binary-size(4), 0x57, 0x41, 0x56, 0x45, _rest::binary>>), do: true
  def wav?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a amr.
  """
  @spec amr?(binary()) :: boolean()
  def amr?(<<0x23, 0x21, 0x41, 0x4D, 0x52, 0x0A, _rest::binary>>), do: true
  def amr?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a aac.
  """
  @spec aac?(binary()) :: boolean()
  def aac?(<<0xFF, 0xF1, 0xF9, _rest::binary>>), do: true
  def aac?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an aiff.
  """
  @spec aiff?(binary()) :: boolean()
  def aiff?(<<0x46, 0x4F, 0x52, 0x4D, _data::binary-size(4), 0x41, 0x49, 0x46, 0x46, _rest::binary>>), do: true
  def aiff?(_binary), do: false
end
