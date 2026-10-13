class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.14.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.14.0/grr-v0.14.0-macos-aarch64.tar.zst"
    sha256 "76ac28dc126337b49cde4377c34b886cb53a24f2554723d11741a7997312bdc2"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.14.0/grr-v0.14.0-linux-aarch64.tar.zst"
      sha256 "f9cc3093582b5f95349cc829d77b84e7f65fb0084a74b7f7175e073c9210f70f"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.14.0/grr-v0.14.0-linux-x86_64.tar.zst"
      sha256 "7976332139d941de8c64515672d3a6b4f5eb099ed84725b82ae795bdd9d2626e"
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
