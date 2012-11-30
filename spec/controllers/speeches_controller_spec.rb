require 'spec_helper'

describe SpeechesController do
  let!(:user) {Fabricate(:user)}
  let!(:project) { Fabricate(:project)}
  let!(:meeting) {Fabricate(:meeting)}
  let!(:speech) { Fabricate(:speech, :user_id => user.id, 
  													:meeting => meeting, 
  													:project_id => project.id) }

  before(:each) { sign_in user }
  describe "#index" do
    it "assigns speeches of the current user" do
      get(:index, :user_id => user.id, :project_id => project.id)
      assigns(:speeches).should eq [speech]
    end
  end
end
