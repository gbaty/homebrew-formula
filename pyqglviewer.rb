require 'formula'

class Pyqglviewer < Formula
  homepage 'http://pyqglviewer.gforge.inria.fr/'

  url   'https://gforge.inria.fr/frs/download.php/33344/PyQGLViewer-0.12.zip'
  sha1   '00f414fb03e7ef8f3adec5c81bc7120e02bdf9ca'

  depends_on 'pyqt'
  depends_on 'sip'
  depends_on 'libqglviewer'

=begin
  def options
    [
      ['--universal', "Build both x86_64 and x86 architectures."],
    ]
  end
=end

=begin
  def patches
    DATA
  end
=end

  def install
    ENV.prepend 'PYTHONPATH', 
                "#{HOMEBREW_PREFIX}/lib/#{which_python}/site-packages", ':'

    system 'python', 'configure.py',
           "--module-install-path=#{lib}/#{which_python}/site-packages",
           "--framework=/Library/Frameworks"
    system 'make'
    system 'make', 'install'

=begin
    args = ["-Q #{prefix}"]

    if ARGV.include? '--universal'
      args << "CONFIG += x86 x86_64"
    end

    cd 'QGLViewer' do
      system "python configure.py", *args
      system "make"
    end
=end

  end

  def caveats; <<-EOS.undent
    For non-Homebrew Python, you need to amend your PYTHONPATH like so:
      export PYTHONPATH=#{HOMEBREW_PREFIX}/lib/#{which_python}/site-packages:$PYTHONPATH
    EOS
  end

  def which_python
    "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
  end
end

