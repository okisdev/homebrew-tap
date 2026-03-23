class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.1.0/tab_v0.1.0_darwin_arm64.tar.gz"
      sha256 "3236d884c30a1a8900b52d589535edb036923a680f086a03637f6110c8946776"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.1.0/tab_v0.1.0_darwin_amd64.tar.gz"
      sha256 "ff70ff4bea73a0d9e9a7798fa432d36613f2f8d68cae2afd68cf3dda17c27f45"
    end
  end

  def install
    bin.install "tab"
    bin.install "tab-daemon"
    bin.install "tab-overlay"
  end

  def caveats
    <<~EOS
      To activate tab, add to your ~/.zshrc:
        eval "\$(tab init zsh)"

      Then install the background service:
        tab install

      Tab requires Accessibility permissions for the overlay popup.
      Grant access in: System Settings → Privacy & Security → Accessibility
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
