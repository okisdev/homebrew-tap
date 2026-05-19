class Wakatime < Formula
  desc "Headless WakaTime tracker"
  homepage "https://github.com/okisdev/wakatime"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.2/wakatime_v0.1.2_darwin_arm64.tar.gz"
      sha256 "fb8fead0e4fb91a66e6627726f33a62352c16651bd4a6c5877ace7017f608770"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.2/wakatime_v0.1.2_darwin_amd64.tar.gz"
      sha256 "900534ec6c9ba13e251d3a8f1fffb12dc1848be86fea73981a602a37b0c1ec8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.2/wakatime_v0.1.2_linux_arm64.tar.gz"
      sha256 "5c6db55e18089390fc199287a7085e1d4497951fbd769fc42b0e5a86f9a11dce"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.2/wakatime_v0.1.2_linux_amd64.tar.gz"
      sha256 "b9c6c5d40f26b69fa3e9eaf2fa5ce12a6c60f4da1a3b4b574b5a5b05b34b0f78"
    end
  end

  def install
    bin.install "wakatime"
  end

  def post_install
    if OS.mac?
      system "codesign", "--force", "--sign", "-", "--identifier", "com.okisdev.wakatime", bin/"wakatime"
    end
  end

  def caveats
    <<~EOS
      configure your WakaTime API key:
        wakatime set-api-key YOUR_WAKATIME_API_KEY

      ask macOS for Accessibility permission:
        wakatime request-accessibility

      start the background tracker on macOS:
        brew services start okisdev/tap/wakatime

      grant Accessibility permission on macOS:
        System Settings -> Privacy & Security -> Accessibility
    EOS
  end

  service do
    name macos: "com.okisdev.wakatime", linux: "wakatime"
    run [opt_bin/"wakatime", "run"]
    keep_alive true
    log_path var/"log/wakatime.log"
    error_log_path var/"log/wakatime.err.log"
  end

  test do
    assert_match "wakatime", shell_output("\#{bin}/wakatime --help")
  end
end
