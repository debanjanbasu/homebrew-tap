class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.1.3"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.3/grr-v2.1.3-macos-aarch64.tar.zst"
    sha256 "50a89d313449b479f67fb1f005a7b0e5019b51446df05e079ecc905b94aad690"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.3/grr-v2.1.3-linux-aarch64.tar.zst"
      sha256 "e1dcb5fd61c30d06b44f0e688e78b285252baad50a8d1748b4344dff7c108415"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.3/grr-v2.1.3-linux-x86_64.tar.zst"
      sha256 "e13f16d9d2914ca7c63383255ffaa7b996a908bbb88674700a311cec0ad2e03b"
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
