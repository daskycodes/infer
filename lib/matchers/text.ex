defmodule Infer.Text do
  @moduledoc """
  Text type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's html.

  See: https://mimesniff.spec.whatwg.org/

  ## Examples

      iex> Infer.Text.is_html("<!DOCTYPE html>")
      true

      iex> Infer.Text.is_html("     <BODY>")
      true

      iex> Infer.Text.is_html("<")
      false

  """
  @spec is_html(binary()) :: boolean()
  def is_html(binary) do
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
      |> String.to_charlist()

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
  """
  @spec is_xml(binary()) :: boolean()
  def is_xml(binary) do
    char_list =
      binary
      |> String.trim()
      |> String.to_charlist()

    starts_with_ignore_ascii_case(char_list, '<?xml')
  end

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a shell script.
  """
  @spec is_shell_script(binary()) :: boolean()
  def is_shell_script(<<"#!", _rest::binary>>), do: true
  def is_shell_script(_binary), do: false

  defp starts_with_ignore_ascii_case(char_list, needle) when length(char_list) >= length(needle) do
    char_list = Enum.take(char_list, length(needle))

    String.downcase(to_string(char_list), :ascii) == String.downcase(to_string(needle), :ascii)
  end

  defp starts_with_ignore_ascii_case(_binary, _needle), do: false
end
