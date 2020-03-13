VERSION = "0.8.0".freeze

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    if OS.mac?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-osx"
      sha256 "53e60591ba270bb00879800c1fe6c414a8286fa069c8b658cf5baa30b62a497e"
    elsif OS.linux?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-linux"
      sha256 "a75079dbc5bf75f506dea78e6e401f23dd6591c9a039e180da59f3bb3a3b39b8"
    end
  end

  devel do
    url "https://github.com/mint-lang/mint/archive/#{VERSION}.tar.gz"
    sha256 "446191acbb3f49933d9fcc20a43bbf994ad35a22e15121ea81d0a48a3d847964"
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
