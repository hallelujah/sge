require 'spec_helper'

describe SGE::CommandRunner do

  it "should define constants" do
    SGE::CommandRunner::SUCCESS_CODE.should == 0
    SGE::CommandRunner::ERROR_CODE.should == 1
  end

  it {should respond_to :output}
  it {should respond_to :errput}
  it {should respond_to :exit_status}
  it {should respond_to :executed?}

  it "should respond to ::run and #run" do
    SGE::CommandRunner.should respond_to(:run)
    SGE::CommandRunner.new.should respond_to(:run)
  end

  it "should instantiate when invoke ::run" do
    instance = SGE::CommandRunner.new
    SGE::CommandRunner.should_receive(:new).once.and_return(instance)
    instance.should_receive(:run)
    SGE::CommandRunner.run("echo 'SGE'")
  end

  it "should reset! when invoke #run" do
    subject.should_receive(:reset!)
    subject.run("echo 'SGE'")
  end

  it "should be executed when invoke #run" do
    subject.should_not be_executed
    subject.run("echo 'SGE'")
    subject.should be_executed
  end

  it "should reset!" do
    subject.reset!
    subject.should_not be_executed
    subject.exit_status.should == SGE::CommandRunner::SUCCESS_CODE
    subject.output.should be_nil
    subject.errput.should be_nil
  end

  it "should catch STDOUT" do
    subject.run("echo 'SGE'")
    subject.output.should == 'SGE'
  end

  it "should catch STDERR" do
    subject.run("echo 'Warning!' 1>&2")
    subject.errput.should == 'Warning!'
  end

  it "should catch exit code" do
    if RUBY_VERSION >= '1.9'
      subject.run("which ls")
      subject.exit_status.should == SGE::CommandRunner::SUCCESS_CODE
      subject.run("which no_such_command")
      subject.exit_status.should == SGE::CommandRunner::ERROR_CODE
    else
      subject.run("which ls")
      subject.exit_status.should == SGE::CommandRunner::SUCCESS_CODE
      subject.run("which no_such_command")
      subject.exit_status.should == SGE::CommandRunner::SUCCESS_CODE
    end
  end
end
