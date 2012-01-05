require 'spec_helper'

describe SGE::QStat::Parser do
  JOBS_FILE = 'spec/data/jobs.sge'

  it "should inherit from Nokogiri::XML::Document" do
    SGE::QStat::Parser.should < Nokogiri::XML::Document
  end

  describe "parsing from qstat -xml" do
    subject { SGE::QStat::Parser.new }

    let(:jobs_stream){ File.read(JOBS_FILE) }

    it "should parse jobs.sge" do
      lambda{ subject.parse(jobs_stream)}.should_not raise_error
    end

    describe "retrieving jobs" do

      subject{ SGE::QStat::Parser.parse(jobs_stream) }

      it "should parse all jobs" do
        subject.jobs.size.should == 6
      end

      it "should parse pending jobs" do
        subject.pending_jobs.size.should == 5
      end

      it "should parse running jobs" do
        subject.running_jobs.size.should == 1
      end
    end

  end

end
