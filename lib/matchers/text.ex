defmodule Infer.Text do
  @moduledoc """
  Text type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's html.

  See: https://mimesniff.spec.whatwg.org/

  ## Examples

      iex> Infer.Text.html?("<!DOCTYPE html>")
      true

      iex> Infer.Text.html?("     <BODY>")
      true

      iex> Infer.Text.html?("<")
      false

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.Text.html?(binary)
      false

  """
  @spec html?(binary()) :: boolean()
  def html?(binary) do
    values = [
      '<!DOCTYPE HTML',
      '<HTML',
      '<HEAD',
      '<SCRIPT',
      '<IFRAME',
      '<H1',
      '<DIV',
      '<FONT',
      '<TABLE',
      '<A',
      '<STYLE',
      '<TITLE',
      '<B',
      '<BODY',
      '<BR',
      '<P',
      '<!--'
    ]

    char_list =
      binary
      |> String.trim()
      |> :binary.bin_to_list()

    Enum.any?(values, fn val ->
      if starts_with_ignore_ascii_case(char_list, val) do
        case Enum.at(char_list, length(val)) do
          0x20 -> true
          0x3E -> true
          _ -> false
        end
      end
    end)
  end

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's xml.

  See: https://mimesniff.spec.whatwg.org/

  ## Examples

      iex> Infer.Text.xml?(~s(<?xml version="1.0" encoding="ISO-8859-1"?>))
      true

      iex> binary = File.read!("test/archives/sample.zip")
      iex> Infer.Text.xml?(binary)
      false

  """
  @spec xml?(binary()) :: boolean()
  def xml?(binary) do
    char_list =
      binary
      |> String.trim()
      |> :binary.bin_to_list()

    starts_with_ignore_ascii_case(char_list, '<?xml')
  end

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a shell script.

  ## Examples

    iex> Infer.Text.shell_script?("#!/bin/sh")
    true

    iex> binary = File.read!("test/archives/sample.zip")
    iex> Infer.Text.shell_script?(binary)
    false

  """
  @spec shell_script?(binary()) :: boolean()
  def shell_script?(<<"#!", _rest::binary>>), do: true
  def shell_script?(_binary), do: false

  defp starts_with_ignore_ascii_case(char_list, needle) when length(char_list) >= length(needle) do
    char_list = Enum.take(char_list, length(needle))

    String.downcase(to_string(char_list), :ascii) == String.downcase(to_string(needle), :ascii)
  end

  defp starts_with_ignore_ascii_case(_binary, _needle), do: false
end
