class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "0.13.5"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.5/grr-v0.13.5-macos-aarch64.tar.zst"
    sha256 "9994c78fb68380324d65f32894e0f34638b4ce9414bca25a06e710549114e836"
  end

  on_linux do
    on_arch :arm do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.5/grr-v0.13.5-linux-aarch64.tar.zst"
      sha256 "c71646939ed64d49fdacb30f57ad46407224f1eea91b440279a56abb8a5c041c"
    end
    on_arch :x86_64 do
      url "https://github.com/debanjanbasu/grr-cli/releases/download/v0.13.5/grr-v0.13.5-linux-x86_64.tar.zst"
      sha256 "39bc185ef35a1c0aaba6fffbd723eb1c3aa0ecefe84be5e69c0f8dc1c55f8b8e"
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
