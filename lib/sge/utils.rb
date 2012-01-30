module SGE
  module Utils
    extend self

    def mkfifo(tmp_dir)
      tmp_pipe = `mktemp -u #{File.join(tmp_dir || "/tmp","fifo.XXXX")}`.strip
      `mkfifo #{tmp_pipe}`
      tmp_pipe
    end

    def execute(cmd)
      # The same as `#{cmd}`
      Kernel.system(cmd)
    end

    def read_file(filename, remove_file = false)
      File.open(filename,"r") do |file|
        yield(file)
      end
      File.unlink(filename) if remove_file
    end

  end
end
