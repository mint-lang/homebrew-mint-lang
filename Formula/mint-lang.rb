class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    url "https://github.com/mint-lang/mint/releases/download/0.7.1/mint-0.7.1-osx"
    sha256 "5913f26524ffffeebdaa817c4e068e5dde3de6779e1631043aa1b18707bdf6a4"
  end

  devel do
    url "https://github.com/mint-lang/mint/archive/0.7.1.tar.gz"
    sha256 "7081804496f3f29bb1b16cf9704d0a87218fb104961df8c208d804e099127460"
  end

  head do
    url "https://github.com/mint-lang/mint.git"
  end

  depends_on "crystal"

  def install
    if build.stable?
      bin.install buildpath/"mint-#{version}-osx" => "mint"
    else
      system "shards", "install"
      system "crystal", "build", "src/mint.cr", "-o", "mint", "-p", "--error-trace"
      bin.install "mint"
    end
  end

  test do
    assert_match "Mint #{version}", shell_output("#{bin}/mint version")
  end
end
