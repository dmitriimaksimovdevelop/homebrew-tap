class MacosNetbirdReconnect < Formula
  desc "macOS daemon to reconnect NetBird VPN after wake"
  homepage "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect"
  url "https://github.com/dmitriimaksimovdevelop/macos-netbird-reconnect/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "6c774543b86254890555b7b1b7e2a1f52dfab76842e1c13b85f41fbeaafd7fa6"
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
