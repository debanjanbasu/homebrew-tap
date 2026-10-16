class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.0.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.1/grr-v2.0.1-macos-aarch64.tar.zst"
    sha256 "17a8589bb76f0a6b09d8bc1d44145350f6130ace43d137e04272f7ff91874f3e"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.1/grr-v2.0.1-linux-aarch64.tar.zst"
      sha256 "6d4f51b35c135c845eb8b918351e8fe635ac8135ddc8058060867b2aa56baf99"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.1/grr-v2.0.1-linux-x86_64.tar.zst"
      sha256 "904c885a45e0d083c2364428ff04c722679ec83e85b54ce1089dddc583c50854"
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
