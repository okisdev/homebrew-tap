class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.7.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.7.2/tab_v0.7.2_darwin_arm64.tar.gz"
      sha256 "b4261923fbc8587a6735743d1e384cdda19f284039ad618e6c3d4e0dfafb4e79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.7.2/tab_v0.7.2_darwin_amd64.tar.gz"
      sha256 "519f9392fe8d2eddfb70a6fc05ebdb59ed6f738131246a56f615a879461541ae"
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
