class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.1.2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.2/grr-v2.1.2-macos-aarch64.tar.zst"
    sha256 "9e0f397eb49be281fa5899fbeef11cb3d4aef2d77b74dcaa851a7a3c9fbc6494"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.2/grr-v2.1.2-linux-aarch64.tar.zst"
      sha256 "b935da56553e4c5e68283646d1d102776b7e72e2ebeb8e7b7fd426389a3808b3"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.2/grr-v2.1.2-linux-x86_64.tar.zst"
      sha256 "c4a3a6e58eacd3ae75305a8cc5e103b2a1e4a946121fcd5c6be66fb94c5f765f"
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
