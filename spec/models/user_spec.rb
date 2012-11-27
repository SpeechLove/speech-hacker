require 'spec_helper'

describe User do
  let (:user) { Fabricate(:user) }

  context "when user is valid" do
    it "should be valid" do
      user.should be_valid
    end

    it "has a name" do
      user.name.should eq user.name
    end
  end

  context "when user is invalid" do
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

  describe "#admin?" do
    let (:user_admin) { Fabricate(:user_admin) }

    it "returns true when user is an admin" do
      user_admin.admin?.should be_true
    end

    it "returns false when a user is not an admin" do
      user.admin?.should be_false
    end
  end

end
