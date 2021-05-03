VERSION = "0.12.0".freeze

case
when OS.mac?
  OS = "osx".freeze
  SHA256 = "005940ab60882824ba27faf2552db40aca76663e885fc74e5faf71538f54b9ae".freeze
when OS.linux?
  OS = "linux".freeze
  SHA256 = "d2ed33e713cbb2848540ea0f4842883a7c733f432ee5ee62e61055222757ab3e".freeze
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
