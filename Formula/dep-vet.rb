class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.6/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "3c72076fcf257dc202401cd10ea11672b53dc991f480e392e2c8ff365acbac37"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.6/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "9d8bfd35dce5ef375db8928978e6972754a3df04d42811b2330fcd84e95fe79e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.6/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1eed8cd5a8a0588c311a2b699d3d380e9e807bb2c70a15ae8d5c6ae9589fa789"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.6/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ce1d5566f740bde779bbd2871a5ff4d9e4c17be5362835cebb5932a24b029759"
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
    assert_match "dep-vet 0.13.6", shell_output("#{bin}/dep-vet --version")
  end
end
