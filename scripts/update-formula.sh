#!/usr/bin/env bash
# Regenerate Formula/grr.rb from the latest grr-cli GitHub release.
#
# Runs inside this tap's own workflow: the release metadata and SHA256SUMS are
# public, so no cross-repo token is needed. Called by
# .github/workflows/update-grr.yml; runnable locally too.
set -euo pipefail
cd "$(dirname "$0")/.."

repo="debanjanbasu/grr-cli"
tag="$(gh api "repos/$repo/releases/latest" --jq .tag_name)"
ver="${tag#v}"
base="https://github.com/$repo/releases/download/$tag"

# Assets are named grr-v<version>-<target>.tar.zst — the v is part of the
# name, not just the tag. Windows has no Homebrew, so only the macOS and
# Linux tarballs are referenced.
sums="$(curl -fsSL "$base/SHA256SUMS")"
asset_sha() {
  printf '%s\n' "$sums" | awk -v name="grr-${tag}-$1.tar.zst" '$2 == name { print $1 }'
}
mac="$(asset_sha macos-aarch64)"
lx64="$(asset_sha linux-x86_64)"
larm="$(asset_sha linux-aarch64)"
for pair in "macOS arm64:$mac" "Linux x86_64:$lx64" "Linux arm64:$larm"; do
  case "$pair" in
    *:) echo "::error::missing asset or checksum for ${pair%%:*}"; exit 1 ;;
  esac
done

cat > Formula/grr.rb <<FORMULA
class Grr < Formula
  desc "Google tools from the terminal, at maximum performance (Gmail, Calendar, Drive, Contacts, Chat, Forms)"
  homepage "https://grr-cli.pages.dev"
  version "$ver"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "$base/grr-${tag}-macos-aarch64.tar.zst"
    sha256 "$mac"
  end

  on_linux do
    on_arch :arm do
      url "$base/grr-${tag}-linux-aarch64.tar.zst"
      sha256 "$larm"
    end
    on_arch :x86_64 do
      url "$base/grr-${tag}-linux-x86_64.tar.zst"
      sha256 "$lx64"
    end
  end

  def install
    # Releases up to v0.8.0 store the binary under its target name
    # (macos-aarch64, linux-x86_64, linux-aarch64); v0.8.1+ ships it as
    # \`grr\`. Accept both, so the formula is correct whichever release the
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
FORMULA
