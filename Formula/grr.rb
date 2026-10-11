class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.13.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.1/grr-v0.13.1-macos-aarch64.tar.zst"
    sha256 "0d22a6fb9d0d9b7c52545d235c9532486c6189fabc47b5963b03163f9a8a52c2"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.1/grr-v0.13.1-linux-aarch64.tar.zst"
      sha256 "33f93e3dad50cffa0da03006ab6907ec4c69499961fa1e1a739e1a75c9a1e7d9"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.1/grr-v0.13.1-linux-x86_64.tar.zst"
      sha256 "09466dbdc02ebacbf914bb786cd3793b35d8733254099e1b95eafad362c18ec7"
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
