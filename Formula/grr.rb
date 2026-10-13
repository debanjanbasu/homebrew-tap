class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.13.4"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.4/grr-v0.13.4-macos-aarch64.tar.zst"
    sha256 "080beaa7a83c54370e4ef952874268a33cb845c95e213700c67d2d9ed243bf53"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.4/grr-v0.13.4-linux-aarch64.tar.zst"
      sha256 "27c26bf38b39af35e85b1b4522c413780b1f8d37c727455501ad0b0e0c88c540"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.4/grr-v0.13.4-linux-x86_64.tar.zst"
      sha256 "8c8d6ed656a5a0d7b65360e77fb5ed171000e8b8ae4a570f3e812ed71302f5a7"
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
