require 'spec_helper'

describe SGE::QAcct::Job do
  context "FIELDS" do
    it "should define constant FIELD" do
      SGE::QAcct::Job.should be_const_defined(:FIELDS)
      SGE::QAcct::Job::FIELDS.should ==  [:qname, :hostname, :group, :owner, :project, :department, :jobname, :jobnumber, :taskid, :account, :priority, :qsub_time, :start_time, :end_time, :granted_pe, :slots, :failed, :exit_status, :ru_wallclock, :ru_utime, :ru_stime, :ru_maxrss, :ru_ixrss, :ru_ismrss, :ru_idrss, :ru_isrss, :ru_minflt, :ru_majflt, :ru_nswap, :ru_inblock, :ru_oublock, :ru_msgsnd, :ru_msgrcv, :ru_nsignals, :ru_nvcsw, :ru_nivcsw, :cpu, :mem, :io, :iow, :maxvmem, :arid]
    end

    it "should define accessor for each fields" do
      SGE::QAcct::Job::FIELDS.each do |f|
        subject.should respond_to(f)
        subject.should respond_to("#{f}=")
      end
    end

  end

  it "should load documents" do
    pending "This is critical and must be implemented"
  end

  it "should execute" do
    Kernel.should_receive("`").once.with("ls").and_return "A list of files"
    subject.class.execute('ls').should == "A list of files"
  end
end
