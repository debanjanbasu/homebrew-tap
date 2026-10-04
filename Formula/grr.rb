class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.8.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.0/grr-v0.8.0-macos-aarch64.tar.zst"
    sha256 "d05a7a4a12448a731a033b436b93cd61de23961a1596e1671552418db46ce898"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.0/grr-v0.8.0-linux-aarch64.tar.zst"
      sha256 "b4aae6c897a4df91f96536ae7d1e187796093b8b9da143074248c7235a923457"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.8.0/grr-v0.8.0-linux-x86_64.tar.zst"
      sha256 "d09227cde508f2325bf181ce48f696c6f4638783612d8bea3ad6b38ed000532a"
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
