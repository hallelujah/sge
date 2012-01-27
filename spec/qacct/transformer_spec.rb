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
end
