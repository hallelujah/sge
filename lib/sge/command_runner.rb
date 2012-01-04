require 'open3'
module SGE
  class CommandRunner
    STDIN  = 0
    STDOUT = 1
    STDERR = 2
    THREAD = 3

    SUCCESS_CODE = 0
    ERROR_CODE = 1

    attr_reader :exit_status, :output, :errput

    def initialize
      reset!
    end

    def self.run(cmd)
      instance = new
      instance.run(cmd)
      instance
    end

    def run(cmd)
      reset!
      Open3.popen3(cmd) do |_, stdout, stderr, w_thread|
        @executed = true
        @exit_status = w_thread.value rescue SUCCESS_CODE
        @output = stdout.read
        @errput = stderr.read
      end
    end

    def reset!
      @executed = false
      @exit_status = SUCCESS_CODE
      @output = nil
      @errput = nil
    end

    def executed?
      !!@executed
    end

  end
end
