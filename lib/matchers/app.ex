defmodule Infer.App do
  @moduledoc """
  Application type matchers based on the [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming))
  """

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a WASM.

  See: http://webassembly.github.io/spec/core/binary/modules.html#binary-magic

  ## Examples

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_wasm(binary)
      true

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.is_wasm(binary)
      false

  """
  @spec is_wasm(binary()) :: boolean()
  def is_wasm(<<0x00, 0x61, 0x73, 0x6D, 0x01, 0x00, 0x00, 0x00, _rest::binary>>), do: true
  def is_wasm(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a EXE or DLL.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.is_exe(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_exe(binary)
      false

  """
  @spec is_exe(binary()) :: boolean()
  def is_exe(<<0x4D, 0x5A, _rest::binary>>), do: true
  def is_exe(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a EXE or DLL.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample.exe")
      iex> Infer.App.is_dll(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_dll(binary)
      false

  """
  @spec is_dll(binary()) :: boolean()
  def is_dll(<<0x4D, 0x5A, _rest::binary>>), do: true
  def is_dll(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a elf.

  DLL and EXE share the same magic number.

  ## Examples

      iex> binary = File.read!("test/app/sample_elf")
      iex> Infer.App.is_elf(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_elf(binary)
      false

  """
  @spec is_elf(binary()) :: boolean()
  def is_elf(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>> = binary) when byte_size(binary) > 52, do: true
  def is_elf(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's compiled java bytecode.
  """
  @spec is_java(binary()) :: boolean()
  def is_java(<<0x43, 0x41, 0x76, 0x45, 0x42, 0x01, 0x42, 0x45, _rest::binary>>), do: true
  def is_java(<<0x43, 0x41, 0x76, 0x45, 0x44, 0x30, 0x30, 0x44, _rest::binary>>), do: true
  def is_java(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's LLVM bitcode.
  """
  @spec is_llvm(binary()) :: boolean()
  def is_llvm(<<0x42, 0x43, _rest::binary>>), do: true
  def is_llvm(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Mach-O binary.
  Mach-O binaries can be one of four variants: x86, x64, PowerPC, "Fat" (x86 + PowerPC)

  See: https://ilostmynotes.blogspot.com/2014/05/mach-o-filetype-identification.html

  ## Examples

      iex> binary = File.read!("test/app/sample_mach_fat")
      iex> Infer.App.is_mach(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_ppc")
      iex> Infer.App.is_mach(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_x64")
      iex> Infer.App.is_mach(binary)
      true

      iex> binary = File.read!("test/app/sample_mach_x86")
      iex> Infer.App.is_mach(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_mach(binary)
      false

  """
  @spec is_mach(binary()) :: boolean()
  def is_mach(<<width, 0xFA, 0xED, 0xFE, _rest::binary>>) when width in [0xCF, 0xCE], do: true
  def is_mach(<<0xFE, 0xED, 0xFA, width, _rest::binary>>) when width in [0xCF, 0xCE], do: true
  def is_mach(<<0xCA, 0xFE, 0xBA, 0xBE, _rest::binary>>), do: true
  def is_mach(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Dalvik Executable (DEX).

  See: https://source.android.com/devices/tech/dalvik/dex-format#dex-file-magic
  """
  @spec is_dex(binary()) :: boolean()
  def is_dex(<<0x64, 0x65, 0x78, 0x0A, _data::binary-size(32), 0x70, _rest::binary>>), do: true
  def is_dex(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Optimized Dalvik Executable (ODEX).

  See: https://source.android.com/devices/tech/dalvik/dex-format#dex-file-magic
  """
  @spec is_dey(binary()) :: boolean()
  def is_dey(<<0x64, 0x65, 0x79, 0x0A, _data::binary-size(36), dex::binary-size(60), _rest::binary>>), do: is_dex(dex)
  def is_dey(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a DER encoded X.509 certificate.

  See: https://github.com/ReFirmLabs/binwalk/blob/master/src/binwalk/magic/crypto#L25-L37
  See: https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs

  ## Examples

      iex> binary = File.read!("test/app/sample.der")
      iex> Infer.App.is_der(binary)
      true

      iex> binary = File.read!("test/app/sample.wasm")
      iex> Infer.App.is_der(binary)
      false

  """
  @spec is_der(binary()) :: boolean()
  def is_der(<<0x30, 0x82, _rest::binary>>), do: true
  def is_der(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for i386 architecture.
  """
  @spec is_coff_i386(binary()) :: boolean()
  def is_coff_i386(<<0x4C, 0x01, _rest::binary>>), do: true
  def is_coff_i386(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for x64 architecture.
  """
  @spec is_coff_x64(binary()) :: boolean()
  def is_coff_x64(<<0x64, 0x86, _rest::binary>>), do: true
  def is_coff_x64(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format for Itanium architecture.
  """
  @spec is_coff_ia64(binary()) :: boolean()
  def is_coff_ia64(<<0x00, 0x02, _rest::binary>>), do: true
  def is_coff_ia64(_binary), do: false

  @doc """
  Takes the binary file contents as arguments. Returns `true` if it's a Common Object File Format.
  """
  @spec is_coff(binary()) :: boolean()
  def is_coff(binary), do: is_coff_x64(binary) || is_coff_i386(binary) || is_coff_ia64(binary)
end
