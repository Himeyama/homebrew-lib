# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LibcudaConvolve < Formula
  desc "convolve"
  homepage "https://blog.hikari-dev.com/"
  url "https://github.com/Himeyama/libcuda-convolve/archive/refs/tags/test4.tar.gz"
  version "0.0.0"
  sha256 "99e7040a85a760c5d09e1162787caee553c26b17fbc7d0efb318b235918fe424"
  license "MIT"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    require "fileutils"

    nvcc_paths = Dir.glob("/usr/**/nvcc")
    raise "Command 'nvcc' not found" if nvcc_paths.empty?

    system "make NVCC=#{nvcc_paths[0]}"
    FileUtils.mkdir_p "#{prefix}/lib"
    FileUtils.mkdir_p "#{prefix}/include"
    system "make install libdir=#{prefix}/lib/ incdir=#{prefix}/include"

    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libcuda-convolve`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
