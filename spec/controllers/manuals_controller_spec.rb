require 'spec_helper'

describe ManualsController do
  let!(:manual) { Fabricate(:manual) }
  let(:mr_user) { Fabricate(:user_testing) }
  # let!(:manual_two_speech) { Fabricate(:manual_two_speech) }

  before(:each) { sign_in mr_user }

  describe 'index' do
    it "assigns a list of manuals" do
      get(:index, :user_id => mr_user.id)
      assigns(:manuals).should eq [manual]
    end

    it "creates a list of speeches for the current user grouped by manuals" do

    end
  end

end
