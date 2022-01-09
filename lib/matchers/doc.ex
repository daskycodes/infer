defmodule Infer.Doc do
  @moduledoc """
  Document type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  use Bitwise

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Word Open XML Format Document (DOCX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.is_docx(binary)
      true

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.is_docx(binary)
      false

  """
  @spec is_docx(binary()) :: boolean()
  def is_docx(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "word/", _rest::binary>>), do: true
  def is_docx(binary), do: msooxml(binary) == :docx

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Excel Open XML Format Spreadsheet (XLSX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.is_xlsx(binary)
      true

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.is_xlsx(binary)
      false

  """
  @spec is_xlsx(binary()) :: boolean()
  def is_xlsx(<<?p, ?k, 0x03, 0x04, _part::binary-size(26), "xl/", _rest::binary>>), do: true
  def is_xlsx(binary), do: msooxml(binary) == :xlsx

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft PowerPoint Open XML Presentation (PPTX) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.pptx")
      iex> Infer.Doc.is_pptx(binary)
      true

      iex> binary = File.read!("test/docs/sample.xlsx")
      iex> Infer.Doc.is_pptx(binary)
      false

  """
  @spec is_pptx(binary()) :: boolean()
  def is_pptx(<<?p, ?k, 0x03, 0x04, _part::binary-size(26), "ppt/", _rest::binary>>), do: true
  def is_pptx(binary), do: msooxml(binary) == :pptx

  defp msooxml(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "[Content_Types].xml", _rest::binary>> = binary) do
    {:ok, parts} = :zip.unzip(binary, [:memory])
    search_x_format(parts)
  end

  defp msooxml(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "docProps", _rest::binary>> = binary) do
    {:ok, parts} = :zip.unzip(binary, [:memory])
    search_x_format(parts)
  end

  defp msooxml(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "_rels/.rels", _rest::binary>> = binary) do
    {:ok, parts} = :zip.unzip(binary, [:memory])
    search_x_format(parts)
  end

  defp msooxml(_binary), do: nil

  defp search_x_format([_, _, {[?w, ?o, ?r, ?d, ?/ | _], _} | _]), do: :docx
  defp search_x_format([_, _, {[?x, ?l, ?/ | _], _} | _]), do: :xlsx
  defp search_x_format([_, _, {[?p, ?p, ?t, ?/ | _], _} | _]), do: :pptx
  defp search_x_format([_, _, _, {[?w, ?o, ?r, ?d, ?/ | _], _} | _]), do: :docx
  defp search_x_format([_, _, _, {[?x, ?l, ?/ | _], _} | _]), do: :xlsx
  defp search_x_format([_, _, _, {[?p, ?p, ?t, ?/ | _], _} | _]), do: :pptx
  defp search_x_format(_), do: :ooxml

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Text Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.odt")
      iex> Infer.Doc.is_odt(binary)
      true

      iex> binary = File.read!("test/docs/sample.odt")
      iex> Infer.Doc.is_pptx(binary)
      false

  """
  @spec is_odt(binary()) :: boolean()
  def is_odt(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.text", _rest::binary>>),
    do: true

  def is_odt(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Spreadsheet Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.ods")
      iex> Infer.Doc.is_ods(binary)
      true

      iex> binary = File.read!("test/docs/sample.ods")
      iex> Infer.Doc.is_odt(binary)
      false

  """
  @spec is_ods(binary()) :: boolean()
  def is_ods(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.spreadsheet", _rest::binary>>),
    do: true

  def is_ods(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's an OpenDocument Presentation Document.

  ## Examples

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.Doc.is_odp(binary)
      true

      iex> binary = File.read!("test/docs/sample.odp")
      iex> Infer.Doc.is_odt(binary)
      false

  """
  @spec is_odp(binary()) :: boolean()
  def is_odp(<<?P, ?K, 0x03, 0x04, _part::binary-size(26), "mimetype", "application/vnd.oasis.opendocument.presentation", _rest::binary>>),
    do: true

  def is_odp(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Word Document (DOC) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.is_doc(binary)
      true

      iex> binary = File.read!("test/docs/sample.docx")
      iex> Infer.Doc.is_doc(binary)
      false

  """
  @spec is_doc(binary()) :: boolean()
  def is_doc(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = doc), do: search_format(doc) == :doc
  def is_doc(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Power Point Document (PPT) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.ppt")
      iex> Infer.Doc.is_ppt(binary)
      true

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.is_ppt(binary)
      false

  """
  @spec is_ppt(binary()) :: boolean()
  def is_ppt(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = ppt), do: search_format(ppt) == :ppt
  def is_ppt(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's Microsoft Excel (XLS) data.

  ## Examples

      iex> binary = File.read!("test/docs/sample.xls")
      iex> Infer.Doc.is_xls(binary)
      true

      iex> binary = File.read!("test/docs/sample.doc")
      iex> Infer.Doc.is_xls(binary)
      false

  """
  @spec is_xls(binary()) :: boolean()
  def is_xls(<<0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, _rest::binary>> = ppt), do: search_format(ppt) == :xls
  def is_xls(_binary), do: false

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
