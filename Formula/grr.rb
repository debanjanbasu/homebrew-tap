class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.8.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.1/grr-v0.8.1-macos-aarch64.tar.zst"
    sha256 "cfc025c59b91d54407f219668d60a7384d30d94416ac227c98303a05fab43172"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.1/grr-v0.8.1-linux-aarch64.tar.zst"
      sha256 "0a443feb95829b34411c0f46d25aa1e762f1195081ed5b59e94878d21cdd0c2b"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.1/grr-v0.8.1-linux-x86_64.tar.zst"
      sha256 "9a0bf265ae8b3ccec4d98f9e0e5e96569704017e7845c57ebaa16c87761e5b16"
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
