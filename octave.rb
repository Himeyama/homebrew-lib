# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Octave < Formula
  desc "GNU Octave Mirror (https://www.octave.org/hg/octave).  Report bugs at https://bugs.octave.org"
  homepage ""
  url "https://github.com/gnu-octave/octave/archive/refs/tags/release-6-3-0.tar.gz"
  sha256 "f0fbb8f1e86140fd69df2b1a4fc4a57febb05b2ca24a38a70f3fb702d4353b0b"
  license "NOASSERTION"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args

    require "fileutils"

    system "./bootstrap"

    FileUtils.mkdir_p ".build", :verbose => true
    FileUtils.cd ".build", :verbose => true
    puts FileUtils.pwd

    system "../configure", "--prefix=#{prefix}"#, "CC=gcc", "CXX=g++", "FC=gfortran"

    system "make"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test octave`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
