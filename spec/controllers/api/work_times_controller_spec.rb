require 'spec_helper'

describe Api::WorkTimesController do

  before :each do
    @user = User.create :name=> 'testing user', email: 'test@user.lo', password: 'password'
    sign_in :user, @user
  end

  describe "GET 'today'" do
    it "returns http success" do
      get 'today'

      response.should be_success
    end

    it "returns work times inside current date" do
      t = Task.create name: 'test task', tags: [], user: @user
      t.work_times << TaskTime.create( start: DateTime.now.to_date + 10.hours, end: DateTime.now.to_date + 12.hours, :user => @user)
      t.work_times << TaskTime.create( start: DateTime.now.to_date + 5.hours, end: DateTime.now.to_date + 8.hours, :user => @user)

      get 'today'

      expect(assigns(:times)).to include(*t.work_times)
    end

    it "returns work times overlapping midnigth" do
      t = Task.create name: 'test task', tags: [], user: @user
      t.work_times << TaskTime.create( start: DateTime.now.to_date - 5.hours, end: DateTime.now.to_date + 12.hours, :user => @user)

      get 'today'

      expect(assigns(:times)).to include(*t.work_times)
    end

    it "do not returns work times in other days" do
      t = Task.create name: 'test task', tags: [], user: @user
      t.work_times << TaskTime.create( start: DateTime.now.to_date - 12.hours, end: DateTime.now.to_date - 5.hours, :user => @user)

      get 'today'

      expect(assigns(:times)).not_to include(*t.work_times)
    end
  end

end