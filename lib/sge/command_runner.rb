require 'open3'
module SGE
  class CommandRunner

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
        # Oh we assume that prior to Ruby 1.9, exit code is always success
        @exit_status = w_thread.value.exitstatus rescue SUCCESS_CODE
        @output = stdout.read.strip
        @errput = stderr.read.strip
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
