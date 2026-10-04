class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.9.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.9.1/grr-v0.9.1-macos-aarch64.tar.zst"
    sha256 "689ef333dccb389ba95627a7b7ff039fb2cd028858e7c7208e7476d40a4c817e"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.9.1/grr-v0.9.1-linux-aarch64.tar.zst"
      sha256 "1a58ccaad1eff8d019aeb9eb58ba5042a5195a4f0ddfbc1f9c875b81cf2d4edd"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.9.1/grr-v0.9.1-linux-x86_64.tar.zst"
      sha256 "375f619b1929f29cc19a1dad79461c03aaac2b7cab535311c1d317d28dccfa70"
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
