module SGE
  module Utils
    extend self

    def mkfifo(tmp_dir)
      tmp_pipe = `mktemp -u #{File.join(tmp_dir || "/tmp","fifo.XXXX")}`.strip
      `mkfifo #{tmp_pipe}`
      tmp_pipe
    end

  end
end