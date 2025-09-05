class MacosNetbirdReconnect < Formula
  desc "macOS daemon to reconnect NetBird VPN after wake"
  homepage "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect"
  url "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "22744911c6d2901bfe90d4bff08d997238d1bfc5f8d7f55e657c75810b316fe5"
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
