class Libgaussian < Formula
    desc ""
    homepage ""
    url "https://github.com/Himeyama/libgaussian/archive/refs/tags/1.01.tar.gz"
    sha256 "4d53f0884dcfcbe5864bd76e2a93ee24d5a5fa38e8f567af7facca787f002097"
    license "MIT"
  
    def install
      system "make"
      ENV["ROOT"] = "#{prefix}"
      system "make", "install"
    end
  
    test do
      system "false"
    end
  end
