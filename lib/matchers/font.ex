defmodule Infer.Font do
  @moduledoc """
  Font type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a woff font.
  """
  @spec is_woff(binary()) :: boolean()
  def is_woff(<<0x77, 0x4F, 0x46, 0x46, 0x00, 0x01, 0x00, 0x00, _rest::binary>>), do: true
  def is_woff(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a woff2 font.
  """
  @spec is_woff2(binary()) :: boolean()
  def is_woff2(<<0x77, 0x4F, 0x46, 0x32, 0x00, 0x01, 0x00, 0x00, _rest::binary>>), do: true
  def is_woff2(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a ttf font.

  ## Examples

      iex> binary = File.read!("test/fonts/sample.ttf")
      iex> Infer.Font.is_ttf(binary)
      true

  """
  @spec is_ttf(binary()) :: boolean()
  def is_ttf(<<0x00, 0x01, 0x00, 0x00, 0x00, _rest::binary>>), do: true
  def is_ttf(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a otf font.
  """
  @spec is_otf(binary()) :: boolean()
  def is_otf(<<0x4F, 0x54, 0x54, 0x4F, 0x00>>), do: true
  def is_otf(_binary), do: false
end
