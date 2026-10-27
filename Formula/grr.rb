class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.5.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.1/grr-v2.5.1-macos-aarch64.tar.zst"
    sha256 "5e05cef29e05a8c460ff84b9a2ce9c6f5fd49419fe1c1208e6ac51f20e4fb969"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.1/grr-v2.5.1-linux-aarch64.tar.zst"
      sha256 "4b4ec89b6f67138a2289525a9185554ad13ae3e8df1567fa5a89880a4a4d87ac"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.5.1/grr-v2.5.1-linux-x86_64.tar.zst"
      sha256 "15fdea2f9b2c6c4e65ee65d690bdf634abb5d7cdcae9b3b1ed951ff0310c15af"
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
