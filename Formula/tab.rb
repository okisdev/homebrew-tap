class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.4.1/tab_v0.4.1_darwin_arm64.tar.gz"
      sha256 "01c82b157121148c7184fdc6dcaac167d0d81062c14644eedc60c21b2d83cbb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.4.1/tab_v0.4.1_darwin_amd64.tar.gz"
      sha256 "ccfc2aef2f5baece9b190d26730c3f83a47484c50528c20819148f010d07fa8b"
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
