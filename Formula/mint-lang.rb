VERSION = "0.9.0".freeze

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    if OS.mac?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-osx"
      sha256 "2f617211c155ca6d6b107e53001542a4b0fb88e8367d2a491fbf48fbcc91355e"
    elsif OS.linux?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-linux"
      sha256 "a6a7ab69e2c4a9ef9f60a81f807eac24aed4a62408a6a6a47a6a66f2c6728187"
    end
  end

  devel do
    url "https://github.com/mint-lang/mint/archive/#{VERSION}.tar.gz"
    sha256 "0486ee56cd36a09a88876759f3997aa7d52a35e48330d7fa91e6a938c165a2ed"
  end

  head do
    url "https://github.com/mint-lang/mint.git"
  end

  depends_on "crystal"

  def install
    if build.stable?
      if OS.mac?
        bin.install buildpath/"mint-#{VERSION}-osx" => "mint"
      elsif OS.linux?
        bin.install buildpath/"mint-#{VERSION}-linux" => "mint"
      end
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
