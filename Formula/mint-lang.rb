VERSION = "0.19.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "99b062d19a678dc6244f4e4b6f465a2361945a93669c27cc5cc79db6dc01a968".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "043a6a14a0f0df34888e7234d33b986ebc760b4761a8ddd8353403b3f8446694".freeze
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
