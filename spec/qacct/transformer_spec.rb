require 'spec_helper'

describe SGE::QAcct::Transformer do
  it { should respond_to(:transformer_file)}
  it { should respond_to(:command)}
  it { should respond_to(:load_from_yaml_file)}

  let (:sh_file){ subject.transformer_file}

  context "#transformer_file" do
    it "should point to the utility file" do
      sh_file.should == File.expand_path('../../../utils/transform_to_yaml.sh', __FILE__)
    end
  end

  context "#command" do
    it "should accept :file options" do
      lambda{ subject.command}.should raise_error("We need a file to dump the yaml")
      subject.command(:file => "hello.world").should == "echo | #{sh_file} > hello.world"
    end

    it "should accept :cmd options" do
      subject.command(:cmd => "echo 'Hello World!'", :file => "hello.world").should == "echo 'Hello World!' | #{sh_file} > hello.world"
    end
  end

  context "#load_from_yaml_file" do
    let(:file){ File.expand_path('../../data/qacct.yml',__FILE__)}

    it "should accept a block" do
      lambda{ subject.load_from_yaml_file(file, false) }.should raise_error
    end

    it "should reads docs" do
      documents = []
      documents.should be_empty
      subject.load_from_yaml_file(file, false) do |doc|
        documents << doc
      end
      documents.should_not be_empty
      documents.should be_all {|d| SGE::QAcct::Job === d }
    end

  end
end
