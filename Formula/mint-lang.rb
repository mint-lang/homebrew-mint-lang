VERSION = "0.13.1".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "e09164f33cdce898c99b4faea2a4d31d4d21a69ac310905dbd6263f3732d1e27".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "f4264e018a1ee2be3bc9bc84e74e0f198f4258afe14aa1d7bd44edb930307c35".freeze
end

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"

  stable do
    url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-#{OS}"
    sha256 SHA256
  end

  head do
    url "https://github.com/mint-lang/mint.git"
    depends_on "crystal" => :build
  end

  def install
    case
    when build.stable?
      bin.install buildpath/"mint-#{VERSION}-#{OS}" => "mint"
    when build.head?
      system "shards", "install"
      system "shards", "build", "--error-trace", "--progress"
      bin.install "bin/mint"
    end
  end

  test do
    assert_match "Mint #{VERSION}", shell_output("#{bin}/mint version")
  end
end
