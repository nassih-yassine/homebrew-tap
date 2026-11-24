class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.3/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "2ad77cbe1636db24b1aefdf032874fa9fb88b7c82344dca53e7dcf5199fb6dc5"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.3/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "25998d3a47b504d34210b4ada03a7c94bb9109dc858897bd8f1b2dbed58bd040"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.3/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b167eb193cf5434e662f605336e952489287399319e6b72e8ae2f585040f986d"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.3/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "450d880cb481106f2ac45627683bdb70b07055982e31c0f480161841454ee478"
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
    assert_match "dep-vet 0.13.3", shell_output("#{bin}/dep-vet --version")
  end
end
