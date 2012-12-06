require 'spec_helper'

describe User do
  subject { Fabricate(:user) }
  it { should validate_presence_of :name }
  it { should have_many :attendances }
  it { should have_many :speeches }
  it { should have_many :meetings }

  let (:user) { Fabricate(:user) }
  let (:user_admin) { Fabricate(:user_admin) }

  describe "#admin?" do
    it "returns true when user is an admin" do
      user_admin.admin?.should be_true
    end

    it "returns false when a user is not an admin" do
      user.admin?.should be_false
    end
  end

  describe "#set_admin" do
    it "sets a non-admin as an admin if make_admin checkbox is checked" do
      user.set_admin(true)
      user.admin?.should be_true
    end

    it "sets an admin as a non-admin if make_admin checkbox is not checked" do
      user_admin.set_admin(false)
      user.admin?.should be_false
    end
  end

  describe "#meeting_speech" do
    it "returns the first speech associated with a meeting" do
      user.meetings[0] = Fabricate(:meeting)
      user.meetings[0].speeches.create :title => "I love cakes!",
                                      :user_id => user.id,
                                      :project_id => Fabricate(:project).id
      user.meeting_speech(user.meetings[0]).should eq user.meetings[0].speeches.first
    end
  end

  describe ".count" do
    it "returns the number of users" do
      User.count.should eq User.all.count
    end
  end
end
