defmodule Infer.App do
  @moduledoc """
  Application type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a WASM.

  See: http://webassembly.github.io/spec/core/binary/modules.html#binary-magic

  ## Examples

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.wasm?(binary)
      true

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.wasm?(binary)
      false

  """
  @spec wasm?(binary()) :: boolean()
  def wasm?(<<0x00, 0x61, 0x73, 0x6D, 0x01, 0x00, 0x00, 0x00, _rest::binary>>), do: true
  def wasm?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a EXE or DLL.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.exe?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.exe?(binary)
      false

  """
  @spec exe?(binary()) :: boolean()
  def exe?(<<0x4D, 0x5A, _rest::binary>>), do: true
  def exe?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a EXE or DLL.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.dll?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.dll?(binary)
      false

  """
  @spec dll?(binary()) :: boolean()
  def dll?(<<0x4D, 0x5A, _rest::binary>>), do: true
  def dll?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a elf.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample_elf")
      iex> Infer.App.elf?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.elf?(binary)
      false

  """
  @spec elf?(binary()) :: boolean()
  def elf?(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>> = binary) when byte_size(binary) > 52, do: true
  def elf?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's compiled java bytecode.
  """
  @spec java?(binary()) :: boolean()
  def java?(<<0x43, 0x41, 0x76, 0x45, 0x42, 0x01, 0x42, 0x45, _rest::binary>>), do: true
  def java?(<<0x43, 0x41, 0x76, 0x45, 0x44, 0x30, 0x30, 0x44, _rest::binary>>), do: true
  def java?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's LLVM bitcode.
  """
  @spec llvm?(binary()) :: boolean()
  def llvm?(<<0x42, 0x43, _rest::binary>>), do: true
  def llvm?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Mach-O binary.
  Mach-O binaries can be one of four variants: x86, x64, PowerPC, "Fat" (x86 + PowerPC)

  See: https://ilostmynotes.blogspot.com/2014/05/mach-o-filetype-identification.html

  ## Examples

      iex> binary = File.read!("test/app/sample_mach_fat")
      iex> Infer.App.mach?(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_ppc")
      iex> Infer.App.mach?(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_x64")
      iex> Infer.App.mach?(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_x86")
      iex> Infer.App.mach?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.mach?(binary)
      false

  """
  @spec mach?(binary()) :: boolean()
  def mach?(<<width, 0xFA, 0xED, 0xFE, _rest::binary>>) when width in [0xCF, 0xCE], do: true
  def mach?(<<0xFE, 0xED, 0xFA, width, _rest::binary>>) when width in [0xCF, 0xCE], do: true
  def mach?(<<0xCA, 0xFE, 0xBA, 0xBE, _rest::binary>>), do: true
  def mach?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Dalvik Executable (DEX).

  See: https://source.android.com/devices/tech/dalvik/dex-format#dex-file-magic
  """
  @spec dex?(binary()) :: boolean()
  def dex?(<<0x64, 0x65, 0x78, 0x0A, _data::binary-size(32), 0x70, _rest::binary>>), do: true
  def dex?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Optimized Dalvik Executable (ODEX).

  See: https://source.android.com/devices/tech/dalvik/dex-format#dex-file-magic
  """
  @spec dey?(binary()) :: boolean()
  def dey?(<<0x64, 0x65, 0x79, 0x0A, _data::binary-size(36), dex::binary-size(60), _rest::binary>>), do: dex?(dex)
  def dey?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a DER encoded X.509 certificate.

  See: https://github.com/ReFirmLabs/binwalk/blob/master/src/binwalk/magic/crypto#L25-L37
  See: https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs

  ## Examples

      iex> binary = File.read!("test/app/sample.der")
      iex> Infer.App.der?(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.der?(binary)
      false

  """
  @spec der?(binary()) :: boolean()
  def der?(<<0x30, 0x82, _rest::binary>>), do: true
  def der?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for i386 architecture.
  """
  @spec coff_i386?(binary()) :: boolean()
  def coff_i386?(<<0x4C, 0x01, _rest::binary>>), do: true
  def coff_i386?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for x64 architecture.
  """
  @spec coff_x64?(binary()) :: boolean()
  def coff_x64?(<<0x64, 0x86, _rest::binary>>), do: true
  def coff_x64?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for Itanium architecture.
  """
  @spec coff_ia64?(binary()) :: boolean()
  def coff_ia64?(<<0x00, 0x02, _rest::binary>>), do: true
  def coff_ia64?(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format.
  """
  @spec coff?(binary()) :: boolean()
  def coff?(binary), do: coff_x64?(binary) || coff_i386?(binary) || coff_ia64?(binary)
end
