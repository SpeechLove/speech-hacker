require 'spec_helper'

describe SpeechesController do
  let!(:user) {Fabricate(:user)}
  let!(:speech) { Fabricate(:speech, :user_id => user.id) }
  before(:each) { sign_in user }
  describe "#index" do
    it "assigns speeches of the current user" do
      get(:index, :user_id => user.id)
      assigns(:speeches).should eq [speech]
    end
  end
end
