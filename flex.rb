# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Flex < Formula
  desc "The Fast Lexical Analyzer - scanner generator for lexing in C and C++"
  homepage ""
  url "https://github.com/westes/flex/releases/download/flex-2.5.39/flex-2.5.39.tar.gz"
  sha256 "71dd1b58158c935027104c830c019e48c73250708af5def45ea256c789318948"
  license "NOASSERTION"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    require "fileutils"
    system "./autogen.sh"
    FileUtils.mkdir_p "build", :verbose => true
    FileUtils.cd "build", :verbose => true
    puts FileUtils.pwd

    system "../configure", "--prefix=#{prefix}"#, "CC=gcc", "CXX=g++", "FC=gfortran"

    system "make", "-j"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test flex`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
