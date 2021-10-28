# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LibcudaGaussian1d < Formula
  homepage "https://blog.hikari-dev.com/"
  desc "A Shared Library of One-Dimensional Gaussian Filters Using GPU"
  url "https://github.com/Himeyama/libcuda-gaussian1d/archive/refs/tags/0.1.0.tar.gz"
  sha256 "6c843219f38ba2d229723cdc8ad01a67e9cd4f0c8eb3e91047f02280d2ff7f4e"
  license "MIT"

  def install
    require "fileutils"

    nvcc_paths = Dir.glob("/usr/**/nvcc")
    raise "Command 'nvcc' not found" if nvcc_paths.empty?

    system "make NVCC=#{nvcc_paths[0]}"
    FileUtils.mkdir_p "#{prefix}/lib"
    FileUtils.mkdir_p "#{prefix}/include"
    system "make install libdir=#{prefix}/lib/ incdir=#{prefix}/include"
  end

  test do
    system "false"
  end
end
