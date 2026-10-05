class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.11.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.0/grr-v0.11.0-macos-aarch64.tar.zst"
    sha256 "5f15ef63b5430014b9cc5f2f6ef5e45adaca2a7806bba392bb985d8472f81a6c"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.0/grr-v0.11.0-linux-aarch64.tar.zst"
      sha256 "b624fdf9cc95b8c42eeb481e4497be8bd9b738103d78fd78ea3480cd4acf2182"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.0/grr-v0.11.0-linux-x86_64.tar.zst"
      sha256 "6086e12f8468b60014500dc9266fb64a80b20da4a542d988331f3ed303c45d71"
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
