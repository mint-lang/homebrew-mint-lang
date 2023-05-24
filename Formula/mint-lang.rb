VERSION = "0.17.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "ebc67f17eeca18cf8187791ad6b496610064b522eec97bc42fbc59266c5d1761".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "3cb26b919c221313e463d805a252423932c36560b2ef3b13c688857e89e93d99".freeze
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
