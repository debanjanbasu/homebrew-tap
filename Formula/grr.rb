class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.11.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.1/grr-v0.11.1-macos-aarch64.tar.zst"
    sha256 "e8760a6613c6f5807e3997131730ef200e40a337de7a556a6fc61228937106d5"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.1/grr-v0.11.1-linux-aarch64.tar.zst"
      sha256 "5dc3598e843182444181f3369224bfba734548495d4228308a9ad3e12bdba3ec"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.11.1/grr-v0.11.1-linux-x86_64.tar.zst"
      sha256 "b06691796d260c1d84697fa62c386d095dd010ad9bab57705328bc3b4801c852"
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
