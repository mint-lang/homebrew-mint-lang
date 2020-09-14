VERSION = "0.10.0".freeze

if OS.mac?
  OS = "osx".freeze
  SHA256 = "0f9b83b1fc067bed5fcb8b1c7a3d3daf69aff27d1b51195b1640531cda98e9cf".freeze
elsif OS.linux?
  OS = "linux".freeze
  SHA256 = "b271fa4065a7b33d51d1932b584e98ff1fa85ea2560806ebdb28ad1681831f0a".freeze
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
