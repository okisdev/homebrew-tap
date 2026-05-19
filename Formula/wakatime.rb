class Wakatime < Formula
  desc "Headless WakaTime tracker"
  homepage "https://github.com/okisdev/wakatime"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.1/wakatime_v0.1.1_darwin_arm64.tar.gz"
      sha256 "10ba1081559833be736f0063ecc927426019b782768d8555ce51978c4e815bd6"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.1/wakatime_v0.1.1_darwin_amd64.tar.gz"
      sha256 "3f7bd991555e5a74df20fe8795992b6fe8fc5d631a6337a792f3b0ba3166ee62"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.1/wakatime_v0.1.1_linux_arm64.tar.gz"
      sha256 "a8a3aa40eca2554e713d5b6cb83c7e9bb22b8c36327f1de73976db2fdcb65014"
    else
      url "https://github.com/okisdev/wakatime/releases/download/v0.1.1/wakatime_v0.1.1_linux_amd64.tar.gz"
      sha256 "ac47df97076683bf2932e9efb9132dfd2d110a7212f6a7a47f1009d543d7b4a8"
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
    run [opt_bin/"wakatime", "run"]
    keep_alive true
    log_path var/"log/wakatime.log"
    error_log_path var/"log/wakatime.err.log"
  end

  test do
    assert_match "wakatime", shell_output("\#{bin}/wakatime --help")
  end
end
