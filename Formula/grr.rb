class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "1.0.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.1/grr-v1.0.1-macos-aarch64.tar.zst"
    sha256 "0db0f8a3c65b1f98fe14673ca5750870e97242330d9cfac68b09104c967ed6f8"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.1/grr-v1.0.1-linux-aarch64.tar.zst"
      sha256 "5898cb558d59583e519ad34398f9d586a89b7509ae3d88d7df9069edbd4e0a91"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.1/grr-v1.0.1-linux-x86_64.tar.zst"
      sha256 "905fe0193e9465a31697815ce3d8cb5336e283c1d2f789c6ad51deb778128596"
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
