# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class NumoNarray < Formula
    desc "Ruby/Numo::NArray - New NArray class library"
    homepage "http://ruby-numo.github.io/narray/"
    url "https://github.com/ruby-numo/numo-narray/archive/refs/tags/v0.9.2.0.tar.gz"
    sha256 "bab0c5599eea821ba80e85e7c6a0fd16a4aef9a49ac41f53ad6c72a2036f6ffd"
    license "BSD-3-Clause"
  
    depends_on "ruby"
    # depends_on "cmake" => :build
  
    def install
      # ENV.deparallelize  # if your formula fails when building in parallel
      # Remove unrecognized options if warned by configure
      # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
      # system "./configure", *std_configure_args, "--disable-silent-rules"
      # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      Dir.chdir "ext/numo/narray"
      system "ruby", "extconf.rb"
      system "make"
      system "mkdir -p #{prefix}/lib"
      system "mkdir -p #{prefix}/include"
      system "cp -v *.so #{prefix}/lib/"
      system "cp -v -r numo #{prefix}/include"
    end
  
    test do
      # `test do` will create, run in and delete a temporary directory.
      #
      # This test will fail and we won't accept that! For Homebrew/homebrew-core
      # this will need to be a test that verifies the functionality of the
      # software. Run the test with `brew test numo-narray`. Options passed
      # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
      #
      # The installed folder is not in the path, so use the entire path to any
      # executables being tested: `system "#{bin}/program", "do", "something"`.
      system "false"
    end
  end
  