require 'spec_helper'

describe SGE::QAcct::Job do
  let(:klass){ SGE::QAcct::Job }
  context "Class Methods" do
    subject{klass}

    it { should respond_to(:command) }
    it { should respond_to(:load_documents) }

    it "should accept a command" do
      klass.command(:cmd => "ls -l").should == "ls -l"
    end

    context "loading documents" do
      let(:file){ File.expand_path('../../data/qacct.sge',__FILE__)}

      it "should load documents" do
        docs = klass.load_documents(:cmd  => "cat #{file}", :remove_tmp_file => true)
        docs.should_not be_empty
      end
      
      it "should receive a block" do
        doc = nil
        klass.load_documents(:cmd  => "cat #{file}", :remove_tmp_file => true) do |d|
          doc = d 
          break
        end
        doc.should be_an_instance_of(klass)
      end
    end

    it "should execute" do
      Kernel.should_receive("system").once.with("ls").and_return "A list of files"
      klass.execute('ls').should == "A list of files"
    end
  end

  context "FIELDS" do
    it "should define constant FIELD" do
      SGE::QAcct::Job.should be_const_defined(:FIELDS)
      SGE::QAcct::Job::FIELDS.should ==  [:qname, :hostname, :group, :owner, :project, :department, :jobname, :jobnumber, :taskid, :account, :priority, :qsub_time, :start_time, :end_time, :granted_pe, :slots, :failed, :exit_status, :ru_wallclock, :ru_utime, :ru_stime, :ru_maxrss, :ru_ixrss, :ru_ismrss, :ru_idrss, :ru_isrss, :ru_minflt, :ru_majflt, :ru_nswap, :ru_inblock, :ru_oublock, :ru_msgsnd, :ru_msgrcv, :ru_nsignals, :ru_nvcsw, :ru_nivcsw, :cpu, :mem, :io, :iow, :maxvmem, :arid]
    end

    it "should define accessor for each fields" do
      klass::FIELDS.each do |f|
        subject.should respond_to(f)
        subject.should respond_to("#{f}=")
      end
    end
  end

end