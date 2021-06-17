VERSION = "0.13.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "a74d08f0559c491864d0d48cb89a1c73ad6cb83e82c3233c1a4e74739e2af18e".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "c50e6975ebb36724b718d6c5717ab8805564d999420491f154255412843d4272".freeze
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
