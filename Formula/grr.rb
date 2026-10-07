class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.12.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.12.0/grr-v0.12.0-macos-aarch64.tar.zst"
    sha256 "fbdb2b5c2a37e4a9b84190eb4681adeefb097f278d17dd9f78185fd638eb8744"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.12.0/grr-v0.12.0-linux-aarch64.tar.zst"
      sha256 "6417c08e9c751ac057fb8eb1ab40ad7c5428e2a6fdcb7f220a10966b30b9e9e6"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.12.0/grr-v0.12.0-linux-x86_64.tar.zst"
      sha256 "dcaead6b1de41a947b63f6ba6dc5eec0c816c828c320f1caeeb91c5c039c3863"
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
