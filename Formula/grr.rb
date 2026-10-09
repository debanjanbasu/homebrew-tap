class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.13.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.0/grr-v0.13.0-macos-aarch64.tar.zst"
    sha256 "5aba59d5438a91033a52ec651b807d62f598f302ed1b3d7d63cbfa461688acd1"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.0/grr-v0.13.0-linux-aarch64.tar.zst"
      sha256 "a6946cdf4533eb01af1bcf2d22c7685a200232a1e7260138ce07db5b148ec57d"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.0/grr-v0.13.0-linux-x86_64.tar.zst"
      sha256 "72588fd5f945e9bbe34968e8c4cc88fda1b0d0cfd748b076d77635eb5acab872"
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
