require 'spec_helper'

describe Api::WorkTimesController do

  describe "GET 'today'" do
    it "returns http success" do
      get 'today'

      response.should be_success
    end

    it "returns work times inside current date" do
      t = Task.create name: 'test task', tags: []
      t.work_times << TaskTime.create( start: DateTime.now.to_date + 10.hours, end: DateTime.now.to_date + 12.hours)
      t.work_times << TaskTime.create( start: DateTime.now.to_date + 5.hours, end: DateTime.now.to_date + 8.hours)

      get 'today'

      expect(assigns(:times)).to include(*t.work_times)
    end

    it "returns work times overlapping midnigth" do
      t = Task.create name: 'test task', tags: []
      t.work_times << TaskTime.create( start: DateTime.now.to_date - 5.hours, end: DateTime.now.to_date + 12.hours)

      get 'today'

      expect(assigns(:times)).to include(*t.work_times)
    end

    it "do not returns work times in other days" do
      t = Task.create name: 'test task', tags: []
      t.work_times << TaskTime.create( start: DateTime.now.to_date - 12.hours, end: DateTime.now.to_date - 5.hours)

      get 'today'

      expect(assigns(:times)).not_to include(*t.work_times)
    end
  end

end