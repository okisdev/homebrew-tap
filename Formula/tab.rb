class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.1.6/tab_v0.1.6_darwin_arm64.tar.gz"
      sha256 "55f76c5473e8c51867e730bb9a882b13129e73886f163902196bf80d302ca0d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.1.6/tab_v0.1.6_darwin_amd64.tar.gz"
      sha256 "3f58a8bafcc43e0f840fba6feac2c2d7dd20321e8b093bed3133ad01c2d61304"
    end
  end

  def install
    bin.install "tab"
    bin.install "tab-daemon"
  end

  def caveats
    <<~EOS
      To activate tab, add to your ~/.zshrc:
        eval "\$(tab init zsh)"

      Then install the background service:
        tab install
    EOS
  end

  service do
    run [opt_bin/"tab-daemon"]
    keep_alive true
    log_path var/"log/tab/daemon.log"
    error_log_path var/"log/tab/daemon.err.log"
  end

  test do
    assert_match "tab", shell_output("\#{bin}/tab --help")
  end
end
