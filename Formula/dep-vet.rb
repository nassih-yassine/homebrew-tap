class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.16.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.1/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "ec2718464dcb9891de9f753f7dd930c7efb9ff3a62c774b9b8b9110e51cf0711"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.1/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "b0603c9b8d50d97278c411a5515b9733b0c5b5f87ce974d74b1e4d003cd5d6d6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.1/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3589f678a2f7acb1ac49d3d88b93f09da7d09372fb292fb2c23f6cd4db4932f1"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.1/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f694c6ce39c6a6a1ed2404ae4781a1b7bce528e9fb772671e4b36ae60b55590c"
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
    assert_match "dep-vet 0.16.1", shell_output("#{bin}/dep-vet --version")
  end
end
