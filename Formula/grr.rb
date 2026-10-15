class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "2.0.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.0/grr-v2.0.0-macos-aarch64.tar.zst"
    sha256 "d1db8ff7ea30263e6cbd877dc9a80c540de2616e2b4c2c7cb713b26269f84696"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.0/grr-v2.0.0-linux-aarch64.tar.zst"
      sha256 "ab97a61dc6942e3a714ffad37f7eddc8fcbb6f4a2d05317db25f19c38ceba0a6"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v2.0.0/grr-v2.0.0-linux-x86_64.tar.zst"
      sha256 "7c936abf62589fcbb9841b84c5a4dd1eddcf917a7467c15e779326ed05a5e6b3"
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
