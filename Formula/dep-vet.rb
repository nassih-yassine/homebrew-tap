class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.5/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "5973c103bca3b83355a7ece6e09fee9a80a9330eb032cde4ff7ae08e177be18d"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.5/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "30cdf2ca07af87b1ee854d75fc659e2c4f5311758934ed0cafe5e84ccb63a952"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.5/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ef78d84a98c888e6179b8116cc8a793653976feb421c1c99c39082669d2b0b23"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.5/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "48d8fc02d1bb71bdde531dc5b0a1a40a5012ef965bae50e9609fbbefacb32904"
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
    assert_match "dep-vet 0.13.5", shell_output("#{bin}/dep-vet --version")
  end
end
