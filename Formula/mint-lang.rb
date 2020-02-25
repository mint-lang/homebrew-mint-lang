VERSION = "0.7.1".freeze

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    if OS.mac?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-osx"
      sha256 "5913f26524ffffeebdaa817c4e068e5dde3de6779e1631043aa1b18707bdf6a4"
    elsif OS.linux?
      url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-linux"
      sha256 "7749ad65c5f201226f2aef2fe44f904b80102bdb7631b28a6cee1f2576c63ffd"
    end
  end

  devel do
    url "https://github.com/mint-lang/mint/archive/#{VERSION}.tar.gz"
    sha256 "7081804496f3f29bb1b16cf9704d0a87218fb104961df8c208d804e099127460"
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
