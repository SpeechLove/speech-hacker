require 'spec_helper'

describe MeetingsController do
  let!(:user) {Fabricate(:user)}
  let!(:user_admin) { Fabricate(:user_admin) }
  let!(:project) { Fabricate(:project) }
  let!(:meeting) { Fabricate(:meeting)}
  let(:meeting2) {Fabricate(:meeting)}
  let!(:speech) { Fabricate(:speech, :user_id => user.id,
                            :meeting => meeting,
                            :project_id => project.id) }

  describe "#index" do
    it "assigns a list of meetings" do
      get(:index)
      assigns(:meetings)[0].should eq(meeting)
    end
  end

  describe "#create" do
    it "creates a new meeting and increases the meeting count" do
      expect do
        post(:create, :meeting => { :meeting_date => meeting2.meeting_date,
                                    :meeting_time => meeting2.meeting_time,
                                    :location => meeting2.location} )
      end.to change( Meeting, :count ).by(1)

    end

    it "assigns the created meeting to meeting" do
      sign_in user_admin
      post(:create, :meeting => { :meeting_date => meeting2.meeting_date,
                                  :meeting_time => meeting2.meeting_time,
                                  :location => meeting2.location} )
      assert_not_nil assigns(:meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#show' do
    it "assigns meeting with the current meeting" do
      sign_in user
      get(:show, :id => meeting.id)
      assigns(:meeting).should eq(meeting)
    end

    it "renders the show page" do
      sign_in user
      get(:show, :id => meeting.id)
      response.should render_template :show
    end
  end

  describe '#destroy' do
    it "destroys the meeting object" do
      sign_in user_admin
      expect {
        delete :destroy, id: meeting
      }.to change(Meeting,:count).by(-1)
    end
  end

  describe '#edit' do
    it "assigns meeting with the current meeting" do
      sign_in user_admin
      get(:edit, :id => meeting.id)
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).should be_valid
    end
  end

  describe '#update' do
    it "updates the meeting" do
      sign_in user_admin
      put(:update, :id => meeting.id, :meeting => {:meeting_date => "1988-11-22", :meeting_time => "05:00"})
      assigns(:meeting).should be_a(Meeting)
      assigns(:meeting).meeting_date.to_s.should eq "1988-11-22"
    end

    it "raises an error if a user tries to update a meeting with invalid info" do
      within_table('meeting_roles_table') do
        click_link("Edit")
      end        
      fill_in 'meeting_role_title', :with => ""
      fill_in 'meeting_role_description', :with => "Roo"
      click_button("Update Meeting role")
      page.should have_content("Title can't be blank")
    end

  end
end
