# Infer

A dependency free library to infer file and MIME type by checking the [magic number](<https://en.wikipedia.org/wiki/Magic_number_(programming)>) signature.

An elixir adaption of the [`infer`](https://github.com/bojand/infer) rust library.

## Installation

The package can be installed
by adding `infer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:infer, "~> 0.2.2"}
  ]
end
```

The docs can
be found at [https://hexdocs.pm/infer](https://hexdocs.pm/infer).

## Examples

### `Infer.get/1`

Takes the binary file contents as argument and returns the `Infer.Type.t()` if the file matches one of the supported types. Returns `nil` otherwise.

```elixir
iex> binary = File.read!("test/images/sample.png")
iex> Infer.get(binary)
%Infer.Type{extension: "png", matcher: &Infer.Image.png?/1, matcher_type: :image, mime_type: "image/png"}
```

### `Infer.get_from_path/1`

Similar to `Infer.get/1`, but takes the file path as argument.

```elixir
iex> Infer.get_from_path("test/images/sample.png")
%Infer.Type{extension: "png", matcher: &Infer.Image.png?/1, matcher_type: :image, mime_type: "image/png"}
```

### `Infer.is?/2`

Takes the binary content and the file extension as arguments. Returns whether the file content is
of the given extension.

```elixir
iex> binary = File.read!("test/images/sample.png")
iex> Infer.is?(binary, "png")
true
```

### `Infer.mime?/2`

Takes the binary content and the file extension as arguments. Returns whether the file content is
of the given mime type.

```elixir
iex> binary = File.read!("test/images/sample.png")
iex> Infer.mime?(binary, "image/png")
true
```

### `Infer.image?/1`

Takes the binary file contents as argument and returns whether the file is an image or not.

```elixir
iex> binary = File.read!("test/images/sample.png")
iex> Infer.image?(binary)
true
```

### `Infer.document?/1`

Takes the binary file contents as argument and returns whether the file is a document (microsoft office, open office)

```elixir
iex> binary = File.read!("test/docs/sample.xlsx")
iex> Infer.document?(binary)
true
```

### `Infer.Doc.docx?/1`

Takes the binary file contents as arguments. Returns `true` if it's Microsoft Word Open XML Format Document (DOCX) data.

```elixir
iex> binary = File.read!("test/docs/sample.docx")
iex> Infer.Doc.docx?(binary)
true
```

## Supported Types

### Image

| MIME                      | Extension |
| ------------------------- | --------- |
| image/jpeg                | jpg       |
| image/jp2                 | jp2       |
| image/png                 | png       |
| image/gif                 | image/web |
| image/x-canon-c32         | cr2       |
| image/tiff                | tif       |
| image/bmp                 | bmp       |
| image/vnd.ms-photo        | jxr       |
| image/vnd.adobe.photoshop | psd       |
| image/vnd.microsoft.icon  | ico       |
| image/heif                | heif      |
| image/avif                | avif      |

### Video

| MIME             | Extension |
| ---------------- | --------- |
| video/mp4        | mp4       |
| video/x-m4v      | m4v       |
| video/x-matroska | mkv       |
| video/webm       | webm      |
| video/quicktime  | mov       |
| video/x-msvideo  | avi       |
| video/x-ms-wmv   | wmv       |
| video/mpeg       | mpg       |
| video/x-flv      | flv       |

### Audio

| MIME         | Extension |
| ------------ | --------- |
| audio/midi   | midi      |
| audio/mpeg   | mp3       |
| audio/m4a    | m4a       |
| audio/ogg    | ogg       |
| audio/x-flac | flac      |
| audio/x-wav  | wav       |
| audio/amr    | amr       |
| audio/aac    | aac       |
| audio/x-aiff | aiff      |

### Document

| MIME                                                                      | Extension |
| ------------------------------------------------------------------------- | --------- |
| application/msword                                                        | doc       |
| application/vnd.openxmlformats-officedocument.wordprocessingml.document   | docx      |
| application/vnd.ms-excel                                                  | xls       |
| application/vnd.openxmlformats-officedocument.spreadsheetml.sheet         | xlsx      |
| application/vnd.ms-powerpoint                                             | ppt       |
| application/vnd.openxmlformats-officedocument.presentationml.presentation | pptx      |
| application/vnd.oasis.opendocument.text                                   | odt       |
| application/vnd.oasis.opendocument.spreadsheet                            | ods       |
| application/vnd.oasis.opendocument.presentation                           | odp       |

## Archive

| MIME                                  | Extension |
| ------------------------------------- | --------- |
| application/epub+zip                  | epub      |
| application/zip                       | zip       |
| application/x-tar                     | tar       |
| application/vnd.rar                   | rar       |
| application/gzip                      | gz        |
| application/x-bzip2                   | bz2       |
| application/x-7z-compressed           | 7z        |
| application/x-xz                      | xz        |
| application/is_pdf                    | pdf       |
| application/x-shockwave-flash         | swf       |
| application/rtf                       | rtf       |
| application/octet-stream              | eot       |
| application/postscript                | ps        |
| application/vnd.sqlite3               | sqlite    |
| application/x-nintendo-nes-rom        | nex       |
| application/x-unix-archive            | ar        |
| application/x-compressed              | Z         |
| application/x-lzip                    | lz        |
| application/x-rpm                     | rpm       |
| application/dicom                     | dcm       |
| application/zstd                      | zst       |
| application/x-ole-storage             | msi       |
| application/x-google-chrome-extension | crx       |
| application/vnd.ms-cab-compressed     | cab       |
| application/vnd.debian.binary-package | deb       |

### Font

| MIME                   | Extension |
| ---------------------- | --------- |
| application/font-woff  | woff      |
| application/font-woff2 | woff2     |
| application/font-sfnt  | ttf       |
| application/font-sfnt  | otf       |

### Book

| MIME                           | Extension |
| ------------------------------ | --------- |
| application/epub+zip           | epub      |
| application/x-mobipocket-ebook | mobi      |

### Application

| MIME                                          | Extension |
| --------------------------------------------- | --------- |
| application/wasm                              | wasm      |
| application/x-executable                      | elf       |
| application/vnd.microsoft.portable-executable | exe       |
| application/vnd.microsoft.portable-executable | dll       |
| application/java                              | class     |
| application/x-llvm                            | bc        |
| application/x-mach-binary                     | mach      |
| application/vnd.android.dex                   | dex       |
| application/vnd.android.det                   | dey       |
| application/x-x509-ca-cert                    | der       |
| application/x-executable                      | obj       |

## License

This project and is licensed under the MIT License - see the [LICENSE](https://github.com/daskycodes/infer/blob/main/LICENSE) file for details.

Copyright (c) 2021 Daniel Khaapamyaki
