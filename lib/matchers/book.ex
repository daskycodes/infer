defmodule Infer.Book do
  @moduledoc """
  Book type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a epub.

  ## Examples

      iex> binary = File.read!("test/books/sample.epub")
      iex> Infer.Book.epub?(binary)
      true

      iex> binary = File.read!("test/books/sample.mobi")
      iex> Infer.Book.epub?(binary)
      false

  """
  @spec epub?(binary()) :: boolean()
  def epub?(
        <<0x50, 0x4B, 0x3, 0x4, _data::binary-size(26), 0x6D, 0x69, 0x6D, 0x65, 0x74, 0x79, 0x70, 0x65, 0x61, 0x70, 0x70, 0x6C, 0x69, 0x63,
          0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2F, 0x65, 0x70, 0x75, 0x62, 0x2B, 0x7A, 0x69, 0x70, _rest::binary>>
      ),
      do: true

  def epub?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a mobi.

  ## Examples

      iex> binary = File.read!("test/books/sample.mobi")
      iex> Infer.Book.mobi?(binary)
      true

      iex> binary = File.read!("test/books/sample.epub")
      iex> Infer.Book.mobi?(binary)
      false

  """
  @spec mobi?(binary()) :: boolean()
  def mobi?(<<_data::binary-size(60), 0x42, 0x4F, 0x4F, 0x4B, 0x4D, 0x4F, 0x42, 0x49, _rest::binary>>), do: true
  def mobi?(_binary), do: false
end
