class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.1.5"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.5/grr-v2.1.5-macos-aarch64.tar.zst"
    sha256 "5a23401114894a9d150b499bdbdb264ff826f73905b07ec883be5ce56d2dbdcc"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.5/grr-v2.1.5-linux-aarch64.tar.zst"
      sha256 "8f02243a0fb8c22e2a9770d0c27659c8915b015703775ba8c8f0551d05d4bde8"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.1.5/grr-v2.1.5-linux-x86_64.tar.zst"
      sha256 "cbc3a8b3d513d7f3e0791011dc78a95d8fa14b0d6e785e7534adcf93c3b8d181"
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
