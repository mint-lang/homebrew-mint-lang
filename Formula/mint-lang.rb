VERSION = "0.9.0".freeze

if OS.mac?
  OS = "osx".freeze
  SHA256 = "2f617211c155ca6d6b107e53001542a4b0fb88e8367d2a491fbf48fbcc91355e".freeze
elsif OS.linux?
  OS = "linux".freeze
  SHA256 = "a6a7ab69e2c4a9ef9f60a81f807eac24aed4a62408a6a6a47a6a66f2c6728187".freeze
end

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"
  url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-#{OS}"
  sha256 SHA256
  head "https://github.com/mint-lang/mint.git"

  depends_on "crystal"

  def install
    if build.stable?
      bin.install buildpath/"mint-#{VERSION}-#{OS}" => "mint"
    else
      system "shards", "install"
      system "crystal", "build", "src/mint.cr", "-o", "mint", "-p", "--error-trace"
      bin.install "mint"
    end
  end

  test do
    assert_match "Mint #{VERSION}", shell_output("#{bin}/mint VERSION")
  end
end
