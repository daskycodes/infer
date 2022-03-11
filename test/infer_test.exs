defmodule InferTest do
  use ExUnit.Case, async: true

  doctest Infer

  describe "Infer.App" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :app))

    test "handles app files" do
      for {_path, binary} <- TestFiles.list(only: :app) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-app files" do
        for {path, binary} <- TestFiles.list(except: :app) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Book" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :book))

    test "handles book files" do
      for {_path, binary} <- TestFiles.list(only: :books) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-book files" do
        for {path, binary} <- TestFiles.list(except: :books) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Image" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :image))

    test "handles image files" do
      for {_path, binary} <- TestFiles.list(only: :images) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-image files" do
        for {path, binary} <- TestFiles.list(except: :images) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Video" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :video))

    test "handles video files" do
      for {_path, binary} <- TestFiles.list(only: :videos) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-video files" do
        for {path, binary} <- TestFiles.list(except: :videos) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Audio" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :audio))

    test "handles audio files" do
      for {_path, binary} <- TestFiles.list(only: :audio) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-audio files" do
        for {path, binary} <- TestFiles.list(except: :audio) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Font" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :font))

    test "handles font files" do
      for {_path, binary} <- TestFiles.list(only: :fonts) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-font files" do
        for {path, binary} <- TestFiles.list(except: :fonts) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Doc" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :doc))

    test "handles document files" do
      for {_path, binary} <- TestFiles.list(only: :docs) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-document files" do
        for {path, binary} <- TestFiles.list(except: :docs) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Archive" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :archive))

    test "handles archive files" do
      for {_path, binary} <- TestFiles.list(only: :archives) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-archive files" do
        for {path, binary} <- TestFiles.list(except: [:archives, :docs, :books]) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end

  describe "Infer.Text" do
    @matchers Infer.Matchers.list() |> Enum.filter(&(&1.matcher_type == :text))

    test "handles text files" do
      for {_path, binary} <- TestFiles.list(only: :text) do
        assert Enum.find(@matchers, & &1.matcher.(binary))
      end
    end

    for %Infer.Type{matcher: matcher} <- @matchers do
      test "#{inspect(matcher)} handles non-text files" do
        for {path, binary} <- TestFiles.list(except: :text) do
          assert {_, false} = {path, unquote(matcher).(binary)}
        end
      end
    end
  end
end
