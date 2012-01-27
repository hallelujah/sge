module SGE
  module Utils
    extend self

    def mkfifo(tmp_dir)
      tmp_pipe = `TMPDIR="#{tmp_dir}" mktemp -u fifo.XXXX -t`.strip
      `mkfifo #{tmp_pipe}`
      tmp_pipe
    end

  end
end
