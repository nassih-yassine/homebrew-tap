#!/usr/bin/env python3
"""Rewrite Formula/dep-vet.rb from the latest dep-vet GitHub release.

The tap is a separate repository, so it pulls from the public release API
instead of needing a token with write access to Dep-Vet. Running this twice for
the same release changes nothing.
"""

import json
import pathlib
import sys
import urllib.request

REPO = "nassih-yassine/Dep-Vet"
FORMULA = pathlib.Path("Formula/dep-vet.rb")

# (platform, arm) -> release asset holding the binary for that platform.
ASSETS = {
    ("macos", True): "dep-vet-aarch64-apple-darwin.tar.xz",
    ("macos", False): "dep-vet-x86_64-apple-darwin.tar.xz",
    ("linux", True): "dep-vet-aarch64-unknown-linux-musl.tar.xz",
    ("linux", False): "dep-vet-x86_64-unknown-linux-musl.tar.xz",
}

TEMPLATE = '''class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/{repo}"
  version "{version}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "{base}/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "{macos_arm}"
    else
      url "{base}/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "{macos_x86}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "{base}/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "{linux_arm}"
    else
      url "{base}/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "{linux_x86}"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "dep-vet"
  end

  test do
    assert_match "dep-vet {version}", shell_output("#{{bin}}/dep-vet --version")
  end
end
'''


def fetch(url: str) -> bytes:
    request = urllib.request.Request(
        url,
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "dep-vet-homebrew-tap",
        },
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read()


def latest_release() -> dict:
    return json.loads(fetch(f"https://api.github.com/repos/{REPO}/releases/latest"))


def checksums(release: dict) -> dict:
    available = {asset["name"]: asset["browser_download_url"] for asset in release["assets"]}
    result = {}
    for key, name in ASSETS.items():
        if name not in available:
            raise SystemExit(f"release is missing {name}")
        text = fetch(available[name + ".sha256"]).decode("utf-8", "replace").strip()
        digest = text.split()[0].lower() if text else ""
        if len(digest) != 64 or any(c not in "0123456789abcdef" for c in digest):
            raise SystemExit(f"unreadable checksum for {name}: {text[:80]!r}")
        result[key] = digest
    return result


def render(release: dict, digests: dict) -> str:
    tag = release["tag_name"]
    if not tag.startswith("v") or tag.count(".") != 2:
        raise SystemExit(f"unexpected tag {tag!r}")
    return TEMPLATE.format(
        repo=REPO,
        version=tag[1:],
        base=f"https://github.com/{REPO}/releases/download/{tag}",
        macos_arm=digests[("macos", True)],
        macos_x86=digests[("macos", False)],
        linux_arm=digests[("linux", True)],
        linux_x86=digests[("linux", False)],
    )


def main() -> int:
    release = latest_release()
    if release.get("draft") or release.get("prerelease"):
        print("latest release is a draft or prerelease; nothing to do")
        return 0
    formula = render(release, checksums(release))
    if FORMULA.is_file() and FORMULA.read_text() == formula:
        print(f"{FORMULA} is already at {release['tag_name']}")
        return 0
    FORMULA.parent.mkdir(parents=True, exist_ok=True)
    FORMULA.write_text(formula)
    print(f"updated {FORMULA} to {release['tag_name']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
