require 'spec_helper'

describe ManualsController do
  let!(:speech) { Fabricate(:speech) }

  describe "#index" do
    before(:each) { sign_in speech.user }

    it "assigns a list of manuals" do
      get(:index, :user_id => speech.user.id)
      assigns(:manuals).should eq [speech.manual]
    end
  end
end
