VERSION = "0.14.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "04f3468e8d8d2b6c970e5033375c7a800a5a7ae6010324108b4607db89632d54".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "3f40f3666b013fef6d42be0e50ed733ba72dac486ab3ccf1fd7b44b26cbc3ebe".freeze
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
