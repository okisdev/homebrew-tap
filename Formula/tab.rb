class Tab < Formula
  desc "Cross-platform terminal autocomplete plugin with fuzzy history matching"
  homepage "https://github.com/okisdev/tab"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.5.0/tab_v0.5.0_darwin_arm64.tar.gz"
      sha256 "5e36959d0bbc85a3d4f730a4e7f6e627dd87dfbae7f6b235465b79e533a96de7"
    else
      url "https://github.com/okisdev/tab/releases/download/v0.5.0/tab_v0.5.0_darwin_amd64.tar.gz"
      sha256 "ae9a78aed47cac4fdee58f3ec495a9ce30a441a210d45829d29389c8bc42c853"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/tab/releases/download/v0.5.0/tab_v0.5.0_linux_arm64.tar.gz"
      sha256 "80d5f5bdf521d3c3494ea9cd2b48a9a558e99cc2064f102f866a765c2df599ff"
    else
      url "https://github.com/okisdev/tab/releases/download/v0.5.0/tab_v0.5.0_linux_amd64.tar.gz"
      sha256 "8817d5c5b7a05f01addc903d293e22d891655c6f5f5a84d9a597eab68422d77f"
    end
  end

  def install
    bin.install "tab"
    bin.install "tab-daemon"
  end

  def caveats
    <<~EOS
      activate tab in your shell:
        zsh:  eval "\$(tab init zsh)"   # ~/.zshrc
        bash: eval "\$(tab init bash)"  # ~/.bashrc
        fish: tab init fish > ~/.config/fish/conf.d/tab.fish

      then install the background service:
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
