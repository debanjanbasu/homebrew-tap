class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.11.2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.2/grr-v0.11.2-macos-aarch64.tar.zst"
    sha256 "ff2adea6b0ff1de314c5662c9b1654b4b4dcd74018db08f7bbb074477bda6172"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.2/grr-v0.11.2-linux-aarch64.tar.zst"
      sha256 "e462495ef175eb48e90682f270fbda6e63126229ba95c81cec8440384bc27c2a"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.2/grr-v0.11.2-linux-x86_64.tar.zst"
      sha256 "d805f3153ec643442e84d799c468604652251a237ec70928e1c7316f3a9f06c9"
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
