defmodule Infer.Matchers do
  @doc """
  Order: Application, Image, Video, Audio, Font Document, Archive, Text.
  """
  @spec list() :: [Infer.Type.t(), ...]
  def list do
    [
      # App
      %Infer.Type{matcher_type: :app, mime_type: "application/wasm", extension: "wasm", matcher: &Infer.App.is_wasm/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-executable", extension: "elf", matcher: &Infer.App.is_elf/1},
      %Infer.Type{
        matcher_type: :app,
        mime_type: "application/vnd.microsoft.portable-executable",
        extension: "exe",
        matcher: &Infer.App.is_exe/1
      },
      %Infer.Type{
        matcher_type: :app,
        mime_type: "application/vnd.microsoft.portable-executable",
        extension: "dll",
        matcher: &Infer.App.is_dll/1
      },
      %Infer.Type{matcher_type: :app, mime_type: "application/java", extension: "class", matcher: &Infer.App.is_java/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-llvm", extension: "bc", matcher: &Infer.App.is_llvm/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-mach-binary", extension: "mach", matcher: &Infer.App.is_mach/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/vnd.android.dex", extension: "dex", matcher: &Infer.App.is_dex/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/vnd.android.dey", extension: "dey", matcher: &Infer.App.is_dey/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-x509-ca-cert", extension: "der", matcher: &Infer.App.is_der/1},
      %Infer.Type{matcher_type: :app, mime_type: "application/x-executable", extension: "obj", matcher: &Infer.App.is_coff/1},
      # Book
      %Infer.Type{matcher_type: :book, mime_type: "application/epub+zip", extension: "epub", matcher: &Infer.Book.is_epub/1},
      %Infer.Type{matcher_type: :book, mime_type: "application/x-mobipocket-ebook", extension: "mobi", matcher: &Infer.Book.is_mobi/1},
      # Image
      %Infer.Type{matcher_type: :image, mime_type: "image/jpeg", extension: "jpg", matcher: &Infer.Image.is_jpeg/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/jp2", extension: "jp2", matcher: &Infer.Image.is_jpeg2000/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/png", extension: "png", matcher: &Infer.Image.is_png/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/gif", extension: "gif", matcher: &Infer.Image.is_gif/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/webp", extension: "webp", matcher: &Infer.Image.is_webp/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/x-canon-cr2", extension: "cr2", matcher: &Infer.Image.is_cr2/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/tiff", extension: "tif", matcher: &Infer.Image.is_tiff/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/bmp", extension: "bmp", matcher: &Infer.Image.is_bmp/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.ms-photo", extension: "jxr", matcher: &Infer.Image.is_jxr/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.adobe.photoshop", extension: "psd", matcher: &Infer.Image.is_psd/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/vnd.microsoft.icon", extension: "ico", matcher: &Infer.Image.is_ico/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/heif", extension: "heif", matcher: &Infer.Image.is_heif/1},
      %Infer.Type{matcher_type: :image, mime_type: "image/avif", extension: "avif", matcher: &Infer.Image.is_avif/1},
      # Video
      %Infer.Type{matcher_type: :video, mime_type: "video/mp4", extension: "mp4", matcher: &Infer.Video.is_mp4/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-m4v", extension: "m4v", matcher: &Infer.Video.is_m4v/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-matroska", extension: "mkv", matcher: &Infer.Video.is_mkv/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/webm", extension: "webm", matcher: &Infer.Video.is_webm/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/quicktime", extension: "mov", matcher: &Infer.Video.is_mov/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-msvideo", extension: "avi", matcher: &Infer.Video.is_avi/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-ms-wmv", extension: "wmv", matcher: &Infer.Video.is_wmv/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/mpeg", extension: "mpg", matcher: &Infer.Video.is_mpeg/1},
      %Infer.Type{matcher_type: :video, mime_type: "video/x-flv", extension: "flv", matcher: &Infer.Video.is_flv/1},
      # Audio
      %Infer.Type{matcher_type: :audio, mime_type: "audio/midi", extension: "midi", matcher: &Infer.Audio.is_midi/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/mpeg", extension: "mp3", matcher: &Infer.Audio.is_mp3/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/m4a", extension: "m4a", matcher: &Infer.Audio.is_m4a/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/ogg", extension: "ogg", matcher: &Infer.Audio.is_ogg/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/x-flac", extension: "flac", matcher: &Infer.Audio.is_flac/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/x-wav", extension: "wav", matcher: &Infer.Audio.is_wav/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/amr", extension: "amr", matcher: &Infer.Audio.is_amr/1},
      %Infer.Type{matcher_type: :audio, mime_type: "audio/aac", extension: "aac", matcher: &Infer.Audio.is_aac/1},
      # Font
      %Infer.Type{matcher_type: :font, mime_type: "application/font-woff", extension: "woff", matcher: &Infer.Font.is_woff/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-woff2", extension: "woff2", matcher: &Infer.Font.is_woff2/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-sfnt", extension: "ttf", matcher: &Infer.Font.is_ttf/1},
      %Infer.Type{matcher_type: :font, mime_type: "application/font-sfnt", extension: "otf", matcher: &Infer.Font.is_otf/1},
      # Doc
      %Infer.Type{matcher_type: :doc, mime_type: "application/msword", extension: "doc", matcher: &Infer.Doc.is_doc/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        extension: "docxc",
        matcher: &Infer.Doc.is_docx/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.ms-excel", extension: "xls", matcher: &Infer.Doc.is_xls/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        extension: "xlsx",
        matcher: &Infer.Doc.is_xlsx/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.ms-powerpoint", extension: "ppt", matcher: &Infer.Doc.is_ppt/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        extension: "pptx",
        matcher: &Infer.Doc.is_pptx/1
      },
      %Infer.Type{matcher_type: :doc, mime_type: "application/vnd.oasis.opendocument.text", extension: "odt", matcher: &Infer.Doc.is_odt/1},
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.oasis.opendocument.spreadsheet",
        extension: "ods",
        matcher: &Infer.Doc.is_ods/1
      },
      %Infer.Type{
        matcher_type: :doc,
        mime_type: "application/vnd.oasis.opendocument.presentation",
        extension: "odp",
        matcher: &Infer.Doc.is_odp/1
      },
      # Archive
      %Infer.Type{matcher_type: :archive, mime_type: "application/epub+zip", extension: "epub", matcher: &Infer.Archive.is_epub/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/zip", extension: "zip", matcher: &Infer.Archive.is_zip/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-tar", extension: "tar", matcher: &Infer.Archive.is_tar/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/vnd.rar", extension: "rar", matcher: &Infer.Archive.is_rar/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/gzip", extension: "gz", matcher: &Infer.Archive.is_gz/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-bzip2", extension: "bz2", matcher: &Infer.Archive.is_bz2/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-7z-compressed", extension: "7z", matcher: &Infer.Archive.is_7z/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-xz", extension: "xz", matcher: &Infer.Archive.is_xz/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/pdf", extension: "pdf", matcher: &Infer.Archive.is_pdf/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-shockwave-flash", extension: "swf", matcher: &Infer.Archive.is_swf/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/rtf", extension: "rtf", matcher: &Infer.Archive.is_rtf/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/octet-stream", extension: "eot", matcher: &Infer.Archive.is_eot/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/postscript", extension: "ps", matcher: &Infer.Archive.is_ps/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/vnd.sqlite3", extension: "sqlite", matcher: &Infer.Archive.is_sqlite/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-nintendo-nes-rom", extension: "nes", matcher: &Infer.Archive.is_nes/1},
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/x-google-chrome-extension",
        extension: "crx",
        matcher: &Infer.Archive.is_crx/1
      },
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/vnd.ms-cab-compressed",
        extension: "cab",
        matcher: &Infer.Archive.is_cab/1
      },
      %Infer.Type{
        matcher_type: :archive,
        mime_type: "application/vnd.debian.binary-package",
        extension: "deb",
        matcher: &Infer.Archive.is_deb/1
      },
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-unix-archive", extension: "ar", matcher: &Infer.Archive.is_ar/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-compressed", extension: "Z", matcher: &Infer.Archive.is_z/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-lzip", extension: "lz", matcher: &Infer.Archive.is_lz/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-rpm", extension: "rpm", matcher: &Infer.Archive.is_rpm/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/dicom", extension: "dcm", matcher: &Infer.Archive.is_dcm/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/zstd", extension: "zst", matcher: &Infer.Archive.is_zst/1},
      %Infer.Type{matcher_type: :archive, mime_type: "application/x-ole-storage", extension: "msi", matcher: &Infer.Archive.is_msi/1},
      # Text
      %Infer.Type{matcher_type: :text, mime_type: "text/html", extension: "html", matcher: &Infer.Text.is_html/1},
      %Infer.Type{matcher_type: :text, mime_type: "text/xml", extension: "xml", matcher: &Infer.Text.is_xml/1},
      %Infer.Type{matcher_type: :text, mime_type: "text/x-shellscript", extension: "sh", matcher: &Infer.Text.is_shell_script/1}
    ]
  end
end
