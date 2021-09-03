# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Jdk16u < Formula
  desc "https://openjdk.java.net/projects/jdk-updates/"
  homepage ""
  url "https://github.com/openjdk/jdk16u/archive/refs/tags/jdk-16.0.2-ga.tar.gz"
  sha256 "d1b01bb5e710a973256a11fe852b7e23523ca8ef04997fa29cf459ba5303a476"
  license "NOASSERTION"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args

    boot_jdk = Pathname.pwd/"boot-jdk"
    resource("boot-jdk").stage boot_jdk
    on_macos do
      boot_jdk /= "Contents/Home"
    end

    system "bash", "configure", "--with-native-debug-symbols=internal", "--disable-hotspot-gtest", "--disable-warnings-as-errors"

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test jdk16u`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
