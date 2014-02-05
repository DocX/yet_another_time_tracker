require 'spec_helper'

describe Api::TimeByTagsController do

  describe "GET 'today'" do
    it "returns http success" do
      get 'today'
      response.should be_success
    end

    it "should set tags of todays tasks" do
      Task.destroy_all

      Task.create(name: 'test task 1', tags: ['tag1', 'tag2'], work_times: [TaskTime.create( start: DateTime.now.to_date + 7.hours, end: DateTime.now.to_date + 8.hours)])
      Task.create(name: 'test task 2', tags: ['tag2', 'tag3'], work_times: [TaskTime.create( start: DateTime.now.to_date + 4.hours, end: DateTime.now.to_date + 5.hours)])
      Task.create(name: 'test task 3', tags: ['tag1', 'tag3'], work_times: [TaskTime.create( start: DateTime.now.to_date + 2.hours, end: DateTime.now.to_date + 3.hours)])

      get 'today'
      expect(assigns(:tags_times)).to satisfy{ |tags|
        ['tag1','tag2','tag3'].all?{|tag| tags.any?{|tag_in_tags| tag_in_tags.first == tag} }
      }
    end
  end

end
