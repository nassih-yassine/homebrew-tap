class DepVet < Formula
  desc "Check a dependency's risk before it enters your lockfile"
  homepage "https://github.com/nassih-yassine/Dep-Vet"
  version "0.13.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.2/dep-vet-aarch64-apple-darwin.tar.xz"
      sha256 "18f2e5f3a8865b0ead2024f7916f6a042272844aa46d909a6d52671b8b47e9f4"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.2/dep-vet-x86_64-apple-darwin.tar.xz"
      sha256 "779f308fe134e714c7b20e636b823a49bbc4ae813295b4ef1dd5e38fa27c05ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.2/dep-vet-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9c46cad96199ef5ba21db021981c99aec4f05f67e669b5554759b8b8d66a9a57"
    else
      url "https://github.com/nassih-yassine/Dep-Vet/releases/download/v0.13.2/dep-vet-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1d712cb38d98c0cd5ba99ad697cf3903c020939ce8f850f7b854ec70941ff635"
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
    assert_match "dep-vet 0.13.2", shell_output("#{bin}/dep-vet --version")
  end
end
