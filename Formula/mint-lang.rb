VERSION = "0.16.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "a91270a02e014c924d0371f01e8d3d28ea61ab2faeac17466cd339f1f6b43029".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "3bacab91654b87e407ab73a82db1f7e94741dde13f812ed01405d945fd5270e5".freeze
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
