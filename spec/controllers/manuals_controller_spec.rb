require 'spec_helper'

describe ManualsController do
  let!(:manual) { Fabricate(:manual) }
  let(:mr_user) { Fabricate(:user_testing) }
  # let!(:manual_two_speech) { Fabricate(:manual_two_speech) }

  before(:each) { sign_in mr_user }

  describe 'index' do
    it "assigns a list of manuals" do
      get(:index, :user_id => mr_user.id)
      assigns(:manuals).should eq Manual.all
    end

  # describe 'show' do
    # it "assigns a current manual" do
    #   controller.stub(:current_user).and_return(mr_user)
    #   get(:show, :user_id => mr_user.id, :id => manual.id)
    #   assigns(:manual).should eq manual
    # end

    # it "assigns a list of the current user's speeches from the current manual" do
    #   #sign_in mr_user
    #   speech = Fabricate(:speech, :user => mr_user)
    #
    #   get(:index, :user_id => mr_user.id, :id => speech.manual.id)
    #   assigns(:speeches_test).first.should eq speech
    # end

    # it "doesn't include speeches from other manuals in the speeches list" do
    #   #sign_in mr_user
    #   speech1 = Fabricate(:speech, :user => mr_user)
    #   speech2 = Fabricate(:speech, :user => mr_user)
    #   puts('---------speech---------')
    #   puts(speech1.inspect)
    #   puts(Speech.all)
    #   get(:index, :user_id => mr_user.id, :id => speech1.manual.id)
    #   assigns(:speeches_test).should eq [speech1]
    # end

    it "creates a list of speeches for the current user grouped by manuals"


    it "can be accessed by the user for the records"

    it "can be accessed by an admin"

    it "cannot be accessed by a non-admin for someone else's files"

  end

end
