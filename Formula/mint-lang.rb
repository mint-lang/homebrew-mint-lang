VERSION = "0.13.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "6719d800720cb5c71904f148cda1f0b9114d5cb0b3d8e8658a70b452ea1b9c36".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "fe44ef022ba3cb8e2d8925c75e3613b2927765d66b361bb66a40a581f91ae7fb".freeze
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
