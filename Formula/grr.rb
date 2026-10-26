class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.5.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.0/grr-v2.5.0-macos-aarch64.tar.zst"
    sha256 "07510ff6d38121f00967a56ab80d4cf3a8209a5fce7bae4969abf2fce4db3760"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.0/grr-v2.5.0-linux-aarch64.tar.zst"
      sha256 "6265669a14c1e525bc86595bcbee5b7fe94110a514b67469636b345239adc881"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.0/grr-v2.5.0-linux-x86_64.tar.zst"
      sha256 "05a7ae597a60f2bdbb99ecf1b70d430c9af36026100c5742213d41d18d5d3724"
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
