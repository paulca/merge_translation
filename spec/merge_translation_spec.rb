require File.dirname(__FILE__) + '/spec_helper'

describe MergeTranslation, "for a new locale" do
  before(:each) do
    @merge = MergeTranslation.new(:from => :'en-US', :to => :fr, :path => File.join(File.dirname(__FILE__), 'fixtures'))
  end
  
  it "should have the English translations to a hash" do
    @merge.from_translation.should be_a_kind_of(Hash)
  end
  
  it "should load up the English translation" do
    @merge.from_translation['test'].should == 'This is a translation'
  end
  
  it "should transfer the English to the French hash" do
    @merge.to_translation.should be_a_kind_of(Hash)
  end
  
  it "should transfer the English to the French" do
    @merge.to_translation['test'].should == 'This is a translation'
  end
end

describe MergeTranslation, "for a current locale" do
  before(:each) do
    @merge = MergeTranslation.new(:from => :'en-US', :to => :de, :path => File.join(File.dirname(__FILE__), 'fixtures'))
  end
  
  it "should have a to_translation" do
    @merge.to_translation.should be_a_kind_of(Hash)
  end
  
  it "should preserve the German translation" do
    @merge.to_translation['test'].should == 'Hier ist eine test!'
  end

  it "should insert the new translation" do
    @merge.to_translation['nut'].should == 'A nut, for deliciousness'
  end
  
  it "should do a deep merge" do
    @merge.to_translation['jan']['lehnardt']['billy'].should == 'Fancy stuff'
  end
  
  it "should really do a deep merge" do
    @merge.to_translation['dashboard']['sidebar']['settings'].should == 'Prufungen'
  end
  
  it "should really do a deep merge" do
    @merge.to_translation['dashboard']['welcome'].should == 'Welcome'
  end
  
  it "should preserve accents" do
    @merge.to_translation['accent'].should == 'é'
  end
  
  it "should render YAML" do
    @merge.to_yaml.size.should > 1
  end
end
