VERSION = "0.12.0".freeze

if OS.mac?
  OS = "osx".freeze
  SHA256 = "005940ab60882824ba27faf2552db40aca76663e885fc74e5faf71538f54b9ae".freeze
elsif OS.linux?
  OS = "linux".freeze
  SHA256 = "d2ed33e713cbb2848540ea0f4842883a7c733f432ee5ee62e61055222757ab3e".freeze
end

class MintLang < Formula
  desc "Refreshing programming language for the front-end web"
  homepage "https://www.mint-lang.com/"
  url "https://github.com/mint-lang/mint/releases/download/#{VERSION}/mint-#{VERSION}-#{OS}"
  sha256 SHA256
  head "https://github.com/mint-lang/mint.git"

  depends_on "crystal"

  def install
    if build.stable?
      bin.install buildpath/"mint-#{VERSION}-#{OS}" => "mint"
    else
      system "shards", "install"
      system "crystal", "build", "src/mint.cr", "-o", "mint", "-p", "--error-trace"
      bin.install "mint"
    end
  end

  test do
    assert_match "Mint #{VERSION}", shell_output("#{bin}/mint VERSION")
  end
end
