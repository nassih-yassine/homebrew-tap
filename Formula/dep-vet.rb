class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.4/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "0e9167f247cc7a66c1a65a040b62e3e91f0d836c2cec230fce84c3e3e6149f19"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.4/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "05011c10b2ab31e64cec949206b7d55ea5c47244980ff5a5069d3afb87c57bec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.4/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8dd4936fdfdd18478cb28364a82770e2106031baa0c6f030a32c4c303938a3f6"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.4/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1364dff0ecc6d282658722327fd05201229e147b30a5293c2007aa84857cf160"
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
    assert_match "dep-vet 0.13.4", shell_output("#{bin}/dep-vet --version")
  end
end
