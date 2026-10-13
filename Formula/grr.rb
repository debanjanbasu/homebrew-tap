class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.15.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.15.0/grr-v0.15.0-macos-aarch64.tar.zst"
    sha256 "b290b1ec475ddaa61ff99bf7a4e573ea85fdb04ce2b260d56a891789c5d104b3"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.15.0/grr-v0.15.0-linux-aarch64.tar.zst"
      sha256 "17d0b9c15ebd449c80b66a49f4e9fe5cdbde55c0b263cfa0727f77d8295047bd"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.15.0/grr-v0.15.0-linux-x86_64.tar.zst"
      sha256 "6ec9b52727f1fbe2fa0c5e0b1759a151a599c4330417d81a22f4983726bfc4dc"
    end
  end

  def install
    # Releases up to v0.8.0 store the binary under its target name
    # (macos-aarch64, linux-x86_64, linux-aarch64); v0.8.1+ ships it as
    # `grr`. Accept both, so the formula is correct whichever release the
    # updater last saw.
    target = if OS.mac?
      "macos-aarch64"
    elsif Hardware::CPU.arm?
      "linux-aarch64"
    else
      "linux-x86_64"
    end
    source = File.exist?(target) ? target : "grr"
    bin.install source => "grr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grr --version")
  end
end
