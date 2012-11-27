require 'spec_helper'

describe User do
  context "when user is valid" do
    let(:user)  { User.new({:name => "Jim", :email => "a@a.com", :password => "blahblah"}) }

    it "should be valid" do
      user.should be_valid
    end

    it "has a name" do
      user.name.should eq "Jim"
    end
  end

  context "when user is invalid" do
    let(:user) { User.new({:name => "Jim", :email => "a@a.com", :password => "blahblah"})}

    it "should return an error for having an invalid name" do
      user.name = ""
      user.should_not be_valid
    end

    it "should return an error for having an invalid email" do
      user.email = "blah"
      user.should_not be_valid
    end

    it "should return an error for having an invalid password" do
      user.password = "blah"
      user.should_not be_valid
    end
  end
end
