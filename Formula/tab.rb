class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.6.0/tab_v0.6.0_darwin_arm64.tar.gz"
      sha256 "c4bd11dcfb83c6e958c3d1a246b154a51e953edec7ed7cc5a70952011aca0e04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.6.0/tab_v0.6.0_darwin_amd64.tar.gz"
      sha256 "e3ea4fdc75ae2606ca10ef1d4c3a4591f96c179cd887f927eca516ef27ba9cf2"
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
