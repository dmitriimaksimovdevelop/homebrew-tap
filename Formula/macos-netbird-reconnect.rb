class MacosNetbirdReconnect < Formula
  desc "macOS daemon to reconnect NetBird VPN after wake"
  homepage "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect"
  url "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "855991d63449669bfd1a92307f399acd9eda21bc8cd7d3aa2625751e9f38f030"
  license "MIT"
  head "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect.git", branch: "main"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--config", "Release"
    bin.install "build/netbird-reconnectd"
  end

  service do
    run [opt_bin/"netbird-reconnectd"]
    keep_alive false
    log_path var/"log/netbird-reconnectd.log"
    error_log_path var/"log/netbird-reconnectd.log"
  end

  test do
    assert_predicate bin/"netbird-reconnectd", :executable?
  end
end
