class MediainfoGui < Formula
  desc "Unified display of technical and tag data for audio/video"
  homepage "https://mediaarea.net/"
  url "https://mediaarea.net/download/binary/mediainfo-gui/0.7.95/MediaInfo_GUI_0.7.95_GNU_FromSource.tar.bz2"
  version "0.7.95"
  sha256 "758d407d2d22037d75c6e6cd0bf83d8cf5c2385c77f5319b8cbc47ca8eb828bd"

  bottle do
    cellar :any
    sha256 "8fef9f03fff1925ab9c5279fb1ac52470139add4b4e2f2adf5a10df08a70d96d" => :sierra
    sha256 "1dab3eb4b641bd231a7526bec9907cbde1f1c71b651c63d8d7dc83b2683cc406" => :el_capitan
    sha256 "c9a7da28d09c2fee2a7c412652f7f564b2c976b8e7207918c301881ed255d912" => :yosemite
  end

  depends_on "pkg-config" => :build
  # fails to build against Leopard's older libcurl
  depends_on "curl" if MacOS.version < :snow_leopard
  depends_on "wxmac"

  def install
    cd "ZenLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--enable-static",
              "--disable-shared"]
      system "./configure", *args
      system "make"
    end

    cd "MediaInfoLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--with-libcurl",
              "--enable-static",
              "--disable-shared"]
      system "./configure", *args
      system "make"
    end

    cd "MediaInfo/Project/GNU/GUI" do
      system "./configure", "--disable-debug", "--enable-staticlibs", "--prefix=#{prefix}"
      system "make", "install"
    end
  end
end