class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.1.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.1/grr-v2.1.1-macos-aarch64.tar.zst"
    sha256 "5e568930c7c966cfcd8624301012066c26772952baca15654c958034e4c74f8d"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.1/grr-v2.1.1-linux-aarch64.tar.zst"
      sha256 "51893b1bf71fd38e1a5853ab09068b01cc2a0376c2cdacd3b882af2e1f061ce3"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.1/grr-v2.1.1-linux-x86_64.tar.zst"
      sha256 "1cb43efa91e2d2e0ef90a680dee3cf5f9392bd06cadd3b72bdf874055a67ced2"
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
