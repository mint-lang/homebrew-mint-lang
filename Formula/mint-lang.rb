class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"
  url "https://github.com/mint-lang/mint.git",
      :tag      => "0.7.1",
      :revision => "a7030461ba9749b5bf257de3b475f9fd9eafa008"
  head "https://github.com/mint-lang/mint.git"

  bottle do
    root_url "https://github.com/homebrew-community/homebrew-bottles/raw/master"
    sha256 "2b4df5aa08315a5ade46b23bae9d716e61546c42d0be20345dd3cf0ef5d43531" => :catalina
  end

  depends_on "crystal"

  def install
    system "shards", "install"
    system "crystal", "build", "src/mint.cr", "-o", "mint", "-p", "--error-trace"
    bin.install "mint"
  end

  test do
    assert_match "Mint #{version}", shell_output("#{bin}/mint version")
  end
end
