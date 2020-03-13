VERSION = "0.8.0".freeze

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    if OS.mac?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-osx"
      sha256 "da62d6561d90e7e39442d934e1469e11bc57ee7d1f59c6e9836f9b20b4e747c2"
    elsif OS.linux?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-linux"
      sha256 "a9c022c97cc468067258022068101ee24196f92002ce24aa405ab5408080f9c6"
    end
  end

  devel do
    url "https://github.com/mint-lang/mint/archive/#{VERSION}.tar.gz"
    sha256 "c558b603c420d582c82e669edbf41fab2b2e66d6badd921d9e4d71afea521a61"
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
