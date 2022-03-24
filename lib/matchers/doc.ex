defmodule Infer.Doc do
  @moduledoc """
  Document type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  use Bitwise

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Word Open XML Format Document (DOCX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.docx?(binary)
      true

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.docx?(binary)
      false

  """
  @spec docx?(binary()) :: boolean()
  def docx?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "word/", _rest::binary>>), do: true
  def docx?(binary), do: msooxml?(binary) == :docx

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Excel Open XML Format Spreadsheet (XLSX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.xlsx?(binary)
      true

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.xlsx?(binary)
      false

  """
  @spec xlsx?(binary()) :: boolean()
  def xlsx?(<<?p, ?k, 0x03, 0x04, _part::binary-size(26), "xl/", _rest::binary>>), do: true
  def xlsx?(binary), do: msooxml?(binary) == :xlsx

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft PowerPoint Open XML Presentation (PPTX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.pptx")
      iex> Infer.Doc.pptx?(binary)
      true

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.pptx?(binary)
      false

  """
  @spec pptx?(binary()) :: boolean()
  def pptx?(<<?p, ?k, 0x03, 0x04, _part::binary-size(26), "ppt/", _rest::binary>>), do: true
  def pptx?(binary), do: msooxml?(binary) == :pptx

  defp msooxml?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "[Content_Types].xml", _rest::binary>> = binary) do
    search_x_format(binary)
  end

  defp msooxml?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "docProps", _rest::binary>> = binary) do
    search_x_format(binary)
  end

  defp msooxml?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "_rels/.rels", _rest::binary>> = binary) do
    search_x_format(binary)
  end

  defp msooxml?(_binary), do: nil

  defp search_x_format(binary) do
    case :binary.match(binary, [<<?w, ?o, ?r, ?d, ?/>>, <<?p, ?p, ?t, ?/>>, <<?x, ?l, ?/>>]) do
      {_pos, 5} -> :docx
      {_pos, 4} -> :pptx
      {_pos, 3} -> :xlsx
      :nomatch -> :ooxml
    end
  end

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Text Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.odt")
      iex> Infer.Doc.odt?(binary)
      true

      iex> binary = File.read!("test/docs/sample.odt")
      iex> Infer.Doc.pptx?(binary)
      false

  """
  @spec odt?(binary()) :: boolean()
  def odt?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.text", _rest::binary>>),
    do: true

  def odt?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Spreadsheet Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.ods")
      iex> Infer.Doc.ods?(binary)
      true

      iex> binary = File.read!("test/docs/sample.ods")
      iex> Infer.Doc.odt?(binary)
      false

  """
  @spec ods?(binary()) :: boolean()
  def ods?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.spreadsheet", _rest::binary>>),
    do: true

  def ods?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Presentation Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.Doc.odp?(binary)
      true

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.Doc.odt?(binary)
      false

  """
  @spec odp?(binary()) :: boolean()
  def odp?(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.presentation", _rest::binary>>),
    do: true

  def odp?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Word Document (DOC) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.doc?(binary)
      true

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.doc?(binary)
      false

  """
  @spec doc?(binary()) :: boolean()
  def doc?(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = doc), do: search_format(doc) == :doc
  def doc?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Power Point Document (PPT) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.ppt")
      iex> Infer.Doc.ppt?(binary)
      true

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.ppt?(binary)
      false

  """
  @spec ppt?(binary()) :: boolean()
  def ppt?(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = ppt), do: search_format(ppt) == :ppt
  def ppt?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Excel (XLS) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.xls")
      iex> Infer.Doc.xls?(binary)
      true

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.xls?(binary)
      false

  """
  @spec xls?(binary()) :: boolean()
  def xls?(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = ppt), do: search_format(ppt) == :xls
  def xls?(_binary), do: false

  defp search_format(
         <<_header::binary-size(30), sector_size::binary-size(2), _dir_offset::binary-size(16), root_directory_index::binary-size(4),
           _rest::binary>> = doc
       ) do
    sector_size = 1 <<< :binary.decode_unsigned(sector_size, :little)

    root_directory_index = :binary.decode_unsigned(root_directory_index, :little)
    root_directory_address = sector_size + root_directory_index * sector_size
    position = root_directory_address + 80

    case doc do
      <<_offset::binary-size(position), 16, 141, 129, 100, 155, 79, 207, 17, 134, 234, 0, 170, 0, 185, 41, 232, _rest::binary>> -> :ppt
      <<_offset::binary-size(position), 6, 9, 2, 0, 0, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 70, _rest::binary>> -> :doc
      <<_offset::binary-size(position), 32, 8, 2, 0, 0, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 70, _rest::binary>> -> :xls
      <<_offset::binary-size(position), 32, 8, 1, 0, 0, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 70, _rest::binary>> -> :xls
      _ -> nil
    end
  end
end
