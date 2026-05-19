class Wakatime < Formula
  desc "Headless WakaTime tracker"
  homepage "https://github.com/okisdev/wakatime"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.0/wakatime_v0.1.0_darwin_arm64.tar.gz"
      sha256 "24a30eaf3e4bfd479acb44da808c68dc7c64a503853f043f341bf7fea2cb6241"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.0/wakatime_v0.1.0_darwin_amd64.tar.gz"
      sha256 "38c855c2871ee787b5f428ea700c761adb1e6193e19ebf8d261db4fbec42a100"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.0/wakatime_v0.1.0_linux_arm64.tar.gz"
      sha256 "bd9d5290d204f0ea7b15ed2f525774c077a20d855efef7b053a567af1696039b"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.0/wakatime_v0.1.0_linux_amd64.tar.gz"
      sha256 "070e01d7d0dc898e8a9edb4fab4b37533992585bcaa58432f7277ec0a1f4d278"
    end
  end

  def install
    bin.install "wakatime"
  end

  def caveats
    <<~EOS
      configure your WakaTime API key:
        wakatime set-api-key YOUR_WAKATIME_API_KEY

      start the background tracker on macOS:
        brew services start okisdev/tap/wakatime

      grant Accessibility permission on macOS:
        System Settings -> Privacy & Security -> Accessibility
    EOS
  end

  service do
    run [opt_bin/"wakatime", "run"]
    keep_alive true
    log_path var/"log/wakatime.log"
    error_log_path var/"log/wakatime.err.log"
  end

  test do
    assert_match "wakatime", shell_output("\#{bin}/wakatime --help")
  end
end
