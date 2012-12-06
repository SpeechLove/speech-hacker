require 'spec_helper'

describe SpeechesController do

  describe "#index" do
    let!(:speech) {Fabricate(:speech)}
    it "assigns speeches of the current user" do
      sign_in speech.user
      get(:index)
      assigns(:speeches).should eq [speech]
    end
  end
end
