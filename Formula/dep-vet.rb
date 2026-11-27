class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.17.0/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "d534dac2f588db11b402bbe483a0854386bfa98a7118f7862ae1407f2bab3928"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.17.0/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "547734f0b3c071795e552dd47d4213525308849922d5f0f72e995e24ee6d3841"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.17.0/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "bc508a2dfc3bc34510e9dec90a98bf93c5460ae7ab3ec21f147cde17edcf8d08"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.17.0/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3ee68bca6c3f6dcf2dedbc40ca63c723da108e446fad55f56ac34382dd415fff"
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
    assert_match "dep-vet 0.17.0", shell_output("#{bin}/dep-vet --version")
  end
end
