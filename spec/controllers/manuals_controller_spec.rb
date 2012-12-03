require 'spec_helper'

describe ManualsController do
  let!(:speech) { Fabricate(:speech) }

    describe 'mr_user assignment' do

      it "assigns a list of manuals" do
        sign_in speech.user
        get(:index, :user_id => speech.user.id)
        assigns(:manuals).should eq [speech.manual]
      end

    end

    it "can be accessed by the user for the records"

    it "can be accessed by an admin"

    it "cannot be accessed by a non-admin for someone else's files"

end








