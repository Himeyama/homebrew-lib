class NumoNarray < Formula
    desc "Ruby/Numo::NArray - New NArray class library"
    homepage "http://ruby-numo.github.io/narray/"
    url "https://github.com/ruby-numo/numo-narray/archive/refs/tags/v0.9.2.0.tar.gz"
    sha256 "bab0c5599eea821ba80e85e7c6a0fd16a4aef9a49ac41f53ad6c72a2036f6ffd"
    license "BSD-3-Clause"
  
    depends_on "ruby"
  
    def install
      Dir.chdir "ext/numo/narray"
      system "ruby", "extconf.rb"
      system "make"
      system "mkdir -p #{lib}"
      system "mkdir -p #{include}"
      system "cp -v narray.so #{lib}/libnarray.so"
      system "cp -v -r numo #{include}"
    end
  
    test do
      system "false"
    end
  end
  
