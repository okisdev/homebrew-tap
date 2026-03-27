class Tab < Formula
  desc "Terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.1.7/tab_v0.1.7_darwin_arm64.tar.gz"
      sha256 "e8d7ab10c3d9c5a7114cf0cca2b9570a681b40c451fc1a00cc45c61cb48d7235"
    end
    if Hardware::CPU.intel?
      url "https://github.com/okisdev/tab/releases/download/v0.1.7/tab_v0.1.7_darwin_amd64.tar.gz"
      sha256 "3d33e70635d54fb89d6d2c220d3956057b0e4715295a2a59b1017f8b52da309b"
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
