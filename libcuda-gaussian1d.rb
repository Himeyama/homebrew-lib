# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LibcudaGaussian1d < Formula
  homepage "https://blog.hikari-dev.com/"
  desc "A Shared Library of One-Dimensional Gaussian Filters Using GPU"
  url "https://github.com/Himeyama/libcuda-gaussian1d/archive/refs/tags/0.0.3.tar.gz"
  sha256 ""
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
