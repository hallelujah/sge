require 'spec_helper'

describe SGE::QStat::Job do

  it "should respond_to define_attributes" do
    SGE::Job.should respond_to(:define_attributes)
  end

  it { should respond_to(:job_number)}
  it { should respond_to(:owner)}
  it { should respond_to(:start_time)}
  it { should respond_to(:queue_name)}
  it { should respond_to(:submission_time)}
  it { should respond_to(:name) }


  it "should retrie vadata from XML document" do
    string = %Q{
    <job_list state="running">
      <JB_job_number>2337</JB_job_number>
      <JAT_prio>0.55451</JAT_prio>
      <JB_name>s20100220_11;init_jour</JB_name>
      <JB_owner>prodsoft</JB_owner>
      <state>r</state>
      <JAT_start_time>2010-02-24T21:55:13</JAT_start_time>
      <queue_name>calcul-x@wousdat-dev.in.weborama.fr</queue_name>
      <slots>1</slots>
    </job_list>
    }
    doc = Nokogiri::XML::Document.new.parse(string)
    lambda{ @job = SGE::QStat::Job.from_document(doc) }.should_not raise_error
    @job.job_number.should == '2337'
    @job.name.should == 's20100220_11;init_jour'
    @job.state.should == 'r'
    @job.owner.should == 'prodsoft'
    @job.start_time.should == '2010-02-24T21:55:13'
    @job.queue_name.should == 'calcul-x@wousdat-dev.in.weborama.fr'
  end
end
