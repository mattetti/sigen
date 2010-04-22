require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sigen" do
  it "should have a default save dir" do
    Sigen.save_dir.should == '/tmp/sigen/signatures'
    File.exist?(Sigen.save_dir).should be_true
  end
  
  it "should let you set a different save dir" do
    Sigen.save_dir ='/tmp/sigen/signature_test'
    Sigen.save_dir.should == '/tmp/sigen/signature_test'
    File.exist?(Sigen.save_dir).should be_true
    # some cleanup
    FileUtils.rm_rf(Sigen.save_dir)
  end
end
