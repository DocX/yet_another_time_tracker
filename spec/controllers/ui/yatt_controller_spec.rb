require 'spec_helper'

describe Ui::YattController do

    # login
  before :each do
    @user = User.create(name: 'Testing user', email: 'test@user.lo', password: 'password')

    sign_in :user, @user
  end

  describe "GET 'main'" do
    it "returns http success" do
      get 'main'
      response.should be_success
    end

    it 'returns fail if user is not logged' do
      sign_out :user
      get 'main'
      response.should_not be_success
    end
  end

end
