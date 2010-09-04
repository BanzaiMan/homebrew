require 'formula'

class Ant < Formula
  url 'http://apache.opensourceresources.org/ant/binaries/apache-ant-1.8.1-bin.tar.gz'
  homepage 'http://ant.apache.org'
  md5 'dc9cc5ede14729f87fe0a4fe428b9185'
  def install
    rm Dir['bin/*.{bat,cmd}'] # no Windows files

    prefix.install %w{ INSTALL KEYS LICENSE NOTICE README WHATSNEW docs etc fetch.xml get-m2.xml }
    libexec.install Dir['*']
    def startup_script name
      <<-EOS.undent
        #!/bin/bash
        exec #{libexec}/bin/#{name} $@
      EOS
    end
    bin.mkpath
    (bin+'ant').write startup_script('ant') # only 'ant'

  end

  def test
    system "#{prefix}/ant/bin/ant -version"
  end
end