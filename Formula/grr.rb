class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "1.0.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.0/grr-v1.0.0-macos-aarch64.tar.zst"
    sha256 "dba9a618ec8c094481da33975024e9f13cf484593d627d18cc8dea6be06ddbef"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.0/grr-v1.0.0-linux-aarch64.tar.zst"
      sha256 "fbdf965f3ba49e1c35a02df38ffdd7dc11ad4f5d855d373eb4b018e14f9bcc41"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v1.0.0/grr-v1.0.0-linux-x86_64.tar.zst"
      sha256 "55dfc39680187fe99daf20dffb622e220c1ba22654f9fdb840e2b7f92a07e323"
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
