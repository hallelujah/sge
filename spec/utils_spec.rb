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

    it "should execute" do
      Kernel.should_receive("system").once.with("ls").and_return "A list of files"
      SGE::Utils.execute('ls').should == "A list of files"
    end

  end

end
