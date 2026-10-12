class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.13.2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.2/grr-v0.13.2-macos-aarch64.tar.zst"
    sha256 "73de3fca4d44f2ad6cc03be828e721ac7f06a0898b423a8b58f00de293b23aa5"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.2/grr-v0.13.2-linux-aarch64.tar.zst"
      sha256 "530193e613a4400c916f5ea36a5ac94a16ac97c2fde6e0cf8932fc7568691933"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.2/grr-v0.13.2-linux-x86_64.tar.zst"
      sha256 "3983468ac50d5d1ce2e34e97e2a521a9865fa9a85f9486011f9b7a25f15d2f3d"
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
