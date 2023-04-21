VERSION = "0.17.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "017468e8a34e68fc5eb011a09fb6bc516aab2e738ed0c11080762377faab9fb9".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "851f39617671b68cf89378bdb08361d4f4a1cbbbcd129776652e6243be319b1a".freeze
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
