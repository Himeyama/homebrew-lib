# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Octave < Formula
  desc ""
  homepage ""
  url "https://ftp.jaist.ac.jp/pub/GNU/octave/octave-4.0.0.tar.gz"
  sha256 "4c7ee0957f5dd877e3feb9dfe07ad5f39b311f9373932f0d2a289dc97cca3280"
  license ""

  # depends_on "cmake" => :build
  
  depends_on "gcc"
  
  depends_on "openblas"
  depends_on "pcre"
  depends_on "readline"
  depends_on "arpack"
  depends_on "fltk"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glpk"
  depends_on "gnuplot"
  depends_on "graphicsmagick"
  depends_on "hdf5"
  depends_on "qhull"
  depends_on "qrupdate"
  depends_on "suite-sparse"
  

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    system "./configure", "--prefix=#{prefix}", "--with-blas=-L#{Formula["openblas"].opt_lib} -lopenblas"
    system "make", "-j"
    system "make", "install"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
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
