defmodule Infer.Matchers do
  @doc """
  Order: Application, Image, Video, Audio, Font Document, Archive, Text.
  """
  @spec list() :: [Infer.Type.t(), ...]
  def list do
    [
      # App
      %Infer.Type{matcher_type: :app, mime_type: "application/wasm", extension: "wasm", matcher: &Infer.App.wasm?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-executable", extension: "elf", matcher: &Infer.App.elf?/1},
      %Infer.Type{
        matcher_type: :app,
        mime_type: "application/vnd.microsoft.portable-executable",
        extension: "exe",
        matcher: &Infer.App.exe?/1
      },
      %Infer.Type{
        matcher_type: :app,
        mime_type: "application/vnd.microsoft.portable-executable",
        extension: "dll",
        matcher: &Infer.App.dll?/1
      },
      %Infer.Type{matcher_type: :app, mime_type: "application/java", extension: "class", matcher: &Infer.App.java?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-llvm", extension: "bc", matcher: &Infer.App.llvm?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-mach-binary", extension: "mach", matcher: &Infer.App.mach?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/vnd.android.dex", extension: "dex", matcher: &Infer.App.dex?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/vnd.android.dey", extension: "dey", matcher: &Infer.App.dey?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-x509-ca-cert", extension: "der", matcher: &Infer.App.der?/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-executable", extension: "obj", matcher: &Infer.App.coff?/1},
      # Book
      %Infer.Type{matcher_type: :book, mime_type: "application/epub+zip", extension: "epub", matcher: &Infer.Book.epub?/1},
      %Infer.Type{matcher_type: :book, mime_type: "application/x-mobipocket-ebook", extension: "mobi", matcher: &Infer.Book.mobi?/1},
      # Image
      %Infer.Type{matcher_type: :image, mime_type: "image/jpeg", extension: "jpg", matcher: &Infer.Image.jpeg?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/jp2", extension: "jp2", matcher: &Infer.Image.jpeg2000?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/png", extension: "png", matcher: &Infer.Image.png?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/gif", extension: "gif", matcher: &Infer.Image.gif?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/webp", extension: "webp", matcher: &Infer.Image.webp?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/x-canon-cr2", extension: "cr2", matcher: &Infer.Image.cr2?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/tiff", extension: "tif", matcher: &Infer.Image.tiff?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/bmp", extension: "bmp", matcher: &Infer.Image.bmp?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.ms-photo", extension: "jxr", matcher: &Infer.Image.jxr?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.adobe.photoshop", extension: "psd", matcher: &Infer.Image.psd?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.microsoft.icon", extension: "ico", matcher: &Infer.Image.ico?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/heif", extension: "heif", matcher: &Infer.Image.heif?/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/avif", extension: "avif", matcher: &Infer.Image.avif?/1},
      # Video
      %Infer.Type{matcher_type: :video, mime_type: "video/mp4", extension: "mp4", matcher: &Infer.Video.mp4?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-m4v", extension: "m4v", matcher: &Infer.Video.m4v?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-matroska", extension: "mkv", matcher: &Infer.Video.mkv?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/webm", extension: "webm", matcher: &Infer.Video.webm?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/quicktime", extension: "mov", matcher: &Infer.Video.mov?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-msvideo", extension: "avi", matcher: &Infer.Video.avi?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-ms-wmv", extension: "wmv", matcher: &Infer.Video.wmv?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/mpeg", extension: "mpg", matcher: &Infer.Video.mpeg?/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-flv", extension: "flv", matcher: &Infer.Video.flv?/1},
      # Audio
      %Infer.Type{matcher_type: :audio, mime_type: "audio/midi", extension: "midi", matcher: &Infer.Audio.midi?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/mpeg", extension: "mp3", matcher: &Infer.Audio.mp3?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/m4a", extension: "m4a", matcher: &Infer.Audio.m4a?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/ogg", extension: "ogg", matcher: &Infer.Audio.ogg?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/x-flac", extension: "flac", matcher: &Infer.Audio.flac?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/x-wav", extension: "wav", matcher: &Infer.Audio.wav?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/amr", extension: "amr", matcher: &Infer.Audio.amr?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/aac", extension: "aac", matcher: &Infer.Audio.aac?/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/x-aiff", extension: "aiff", matcher: &Infer.Audio.aiff?/1},
      # Font
      %Infer.Type{matcher_type: :font, mime_type: "application/font-woff", extension: "woff", matcher: &Infer.Font.woff?/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-woff2", extension: "woff2", matcher: &Infer.Font.woff2?/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-sfnt", extension: "ttf", matcher: &Infer.Font.ttf?/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-sfnt", extension: "otf", matcher: &Infer.Font.otf?/1},
      # Doc
      %Infer.Type{matcher_type: :doc, mime_type: "application/msword", extension: "doc", matcher: &Infer.Doc.doc?/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        extension: "docxc",
        matcher: &Infer.Doc.docx?/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.ms-excel", extension: "xls", matcher: &Infer.Doc.xls?/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        extension: "xlsx",
        matcher: &Infer.Doc.xlsx?/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.ms-powerpoint", extension: "ppt", matcher: &Infer.Doc.ppt?/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        extension: "pptx",
        matcher: &Infer.Doc.pptx?/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.oasis.opendocument.text", extension: "odt", matcher: &Infer.Doc.odt?/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.oasis.opendocument.spreadsheet",
        extension: "ods",
        matcher: &Infer.Doc.ods?/1
      },
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.oasis.opendocument.presentation",
        extension: "odp",
        matcher: &Infer.Doc.odp?/1
      },
      # Archive
      %Infer.Type{matcher_type: :archive, mime_type: "application/epub+zip", extension: "epub", matcher: &Infer.Archive.epub?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/zip", extension: "zip", matcher: &Infer.Archive.zip?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-tar", extension: "tar", matcher: &Infer.Archive.tar?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/vnd.rar", extension: "rar", matcher: &Infer.Archive.rar?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/gzip", extension: "gz", matcher: &Infer.Archive.gz?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-bzip2", extension: "bz2", matcher: &Infer.Archive.bz2?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-7z-compressed", extension: "7z", matcher: &Infer.Archive.sevenz?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-xz", extension: "xz", matcher: &Infer.Archive.xz?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/pdf", extension: "pdf", matcher: &Infer.Archive.pdf?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-shockwave-flash", extension: "swf", matcher: &Infer.Archive.swf?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/rtf", extension: "rtf", matcher: &Infer.Archive.rtf?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/octet-stream", extension: "eot", matcher: &Infer.Archive.eot?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/postscript", extension: "ps", matcher: &Infer.Archive.ps?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/vnd.sqlite3", extension: "sqlite", matcher: &Infer.Archive.sqlite?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-nintendo-nes-rom", extension: "nes", matcher: &Infer.Archive.nes?/1},
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/x-google-chrome-extension",
        extension: "crx",
        matcher: &Infer.Archive.crx?/1
      },
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/vnd.ms-cab-compressed",
        extension: "cab",
        matcher: &Infer.Archive.cab?/1
      },
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/vnd.debian.binary-package",
        extension: "deb",
        matcher: &Infer.Archive.deb?/1
      },
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-unix-archive", extension: "ar", matcher: &Infer.Archive.ar?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-compressed", extension: "Z", matcher: &Infer.Archive.z?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-lzip", extension: "lz", matcher: &Infer.Archive.lz?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-rpm", extension: "rpm", matcher: &Infer.Archive.rpm?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/dicom", extension: "dcm", matcher: &Infer.Archive.dcm?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/zstd", extension: "zst", matcher: &Infer.Archive.zst?/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-ole-storage", extension: "msi", matcher: &Infer.Archive.msi?/1},
      # Text
      %Infer.Type{matcher_type: :text, mime_type: "text/html", extension: "html", matcher: &Infer.Text.html?/1},
      %Infer.Type{matcher_type: :text, mime_type: "text/xml", extension: "xml", matcher: &Infer.Text.xml?/1},
      %Infer.Type{matcher_type: :text, mime_type: "text/x-shellscript", extension: "sh", matcher: &Infer.Text.shell_script?/1}
    ]
  end
end
