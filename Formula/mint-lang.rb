VERSION = "0.11.0".freeze

if OS.mac?
  OS = "osx".freeze
  SHA256 = "62da6309581f860aeaa8c10d4d7d5935806d2ad0378f446397b9972b6960cdab".freeze
elsif OS.linux?
  OS = "linux".freeze
  SHA256 = "4e3df00441347df216b60f7285d89fb0b5355e856d4ae8839148a43731622e96".freeze
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
