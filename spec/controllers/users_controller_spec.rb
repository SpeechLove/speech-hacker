require 'spec_helper'


describe UsersController do
  describe "#index" do
    it "assigns a list of users" do
      get(:index)
      assigns(:users).first.should be_an_instance_of(User)
    end

    # it "redirects a non-admin user" do
    #   get(:index)
    # end
  end
end