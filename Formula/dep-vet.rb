class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.1/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "7e294f52cf13fa73b8753cf9902f6b193fc655d4c55d449ba7b63edd383f4bca"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.1/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "c411d401970e358ad94db9566d7670324bfdffdfae580ca46b7cf2074418ffcf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.1/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "99bbf9aa2d7102980ceec32969d5080261d2a5e7cd252adfef172b1195aa6891"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.1/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "46369d85d171534aea3851f54241e3b6108679870c87403787605c7d1eb9f902"
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
    assert_match "dep-vet 0.13.1", shell_output("#{bin}/dep-vet --version")
  end
end
