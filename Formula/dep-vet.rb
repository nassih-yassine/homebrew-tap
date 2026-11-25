class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.0/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "de2aa11e5b5059444fd47a251d0813248e4dd1366f869907d8c4e3376d6957e1"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.0/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "11a2dfad5d1cbe02792902993e814498d7585aa16d5f218ea6c8dc8b71f48586"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.0/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ac04bd500a0c72b8e5ae8c282a953a66a5822fcd68a5d311fd9cef036c37db69"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.16.0/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "80b02ed7ac4497f0868c57420f1221138a9782481e38484839152763aa15a833"
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
    assert_match "dep-vet 0.16.0", shell_output("#{bin}/dep-vet --version")
  end
end
