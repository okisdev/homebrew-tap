class Wakatime < Formula
  desc "Headless WakaTime tracker for macOS"
  homepage "https://github.com/okisdev/wakatime"
  url "https://github.com/okisdev/wakatime.git", branch: "main"
  version "0.1.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  def caveats
    <<~EOS
      Configure your WakaTime API key:
        wakatime set-api-key YOUR_WAKATIME_API_KEY

      Start the background tracker:
        brew services start okisdev/tap/wakatime

      Grant Accessibility permission in:
        System Settings -> Privacy & Security -> Accessibility

      Diagnostics:
        wakatime doctor
    EOS
  end

  service do
    run [opt_bin/"wakatime", "run"]
    keep_alive true
    log_path var/"log/wakatime.log"
    error_log_path var/"log/wakatime.err.log"
  end

  test do
    assert_match "wakatime", shell_output("#{bin}/wakatime --help")
  end
end
