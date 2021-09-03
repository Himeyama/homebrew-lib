# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tcl < Formula
    desc ""
    homepage ""
    url "https://prdownloads.sourceforge.net/tcl/tcl8.5.19-src.tar.gz"
    sha256 "d3f04456da873d17f02efc30734b0300fb6c3b85028d445fe284b83253a6db18"
    license ""
  
    # depends_on "cmake" => :build
  
    def install
      # ENV.deparallelize  # if your formula fails when building in parallel
      # Remove unrecognized options if warned by configure
      # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
      # system "./configure", *std_configure_args, "--disable-silent-rules"
      # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      require "fileutils"
      # FileUtils.mkdir_p ".build", :verbose => true
      FileUtils.cd "unix", :verbose => true
      puts FileUtils.pwd
      system "./configure", "--prefix=#{prefix}", "--with-encoding=UTF-8"
      system "make", "-j"
      system "make", "install"
    end
  
    test do
      # `test do` will create, run in and delete a temporary directory.
      #
      # This test will fail and we won't accept that! For Homebrew/homebrew-core
      # this will need to be a test that verifies the functionality of the
      # software. Run the test with `brew test tcl`. Options passed
      # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
      #
      # The installed folder is not in the path, so use the entire path to any
      # executables being tested: `system "#{bin}/program", "do", "something"`.
      system "false"
    end
  end
  