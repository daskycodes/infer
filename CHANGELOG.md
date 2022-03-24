# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.2.2 (2022-03-24)

- Changes
  - Improve `docx` `pptx` and `xlsx` matcher performance by replacing `:zip.unzip/2` with `:binary.match/2`.
  - Add optional second argument, `byte_size`, to `Infer.get_from_path/2` to allow checking only the necessary part of the file.

## 0.2.1 (2022-03-10)

- Bug fixes
  - Fix UnicodeConversionError by @adriankumpf

## 0.2.0 (2022-01-09)

- Changes
  - `is_*` functions have no prefix and end with a question mark, to conform with elixir's conventions

## 0.1.1 (2022-01-09)

- Enhancements
  - Add AIFF audio file support

## 0.1.0 (2021-12-26)

Initial release
