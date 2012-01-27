require 'spec_helper'

describe SGE::Utils do
  it { should respond_to(:mkfifo)}

  describe "#mkfifo" do
    it "should make a fifo file" do
      lambda{ SGE::Utils.mkfifo }.should raise_error
      tmp_dir = "."
      file = SGE::Utils.mkfifo(tmp_dir)
      file.should =~ %r<^\.\/fifo\.....>
      File.stat(file).should be_pipe
      File.unlink file
    end
  end

end
