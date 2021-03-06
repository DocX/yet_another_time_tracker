require 'spec_helper'

describe Api::CurrentTaskController do

  # login
  before :each do
    @user = User.create(name: 'Testing user', email: 'test@user.lo', password: 'password')

    sign_in :user, @user
  end

  describe "GET 'show'" do
    it "returns http not_found when no current task is there" do
      Task.destroy_all

      get 'show'
      response.should be_not_found
    end

    it "returns http success and json of task when current task is there" do
      t = Task.create_current(
        @user,
        name: 'test task',
        tags: ['tag1','tag2'],
        estimated_seconds: 100
        )

      get 'show'
      response.should be_success
      expect(assigns(:current_task)._id).to eq(t._id)
    end
  end

  describe "POST 'create'" do

    def post_valid
      {
        name: 'test task',
        tags: ['tag1', 'tag2'],
        estimated_seconds: 120
      }
    end

    it 'returns http success if valid attributes given' do
      post 'create', post_valid

      response.should be_success
    end

    it 'creates new task' do
      before_count = Task.count

      post 'create', post_valid

      expect(Task.count).to eq(before_count + 1)
    end

    it 'makes current task has posted values' do
      post 'create', post_valid

      t = Task.current @user
      expect(t.name).to eq(post_valid[:name])
      expect(t.tags).to match_array(post_valid[:tags])
      expect(t.estimated_seconds.to_i).to eq(post_valid[:estimated_seconds].to_i)
    end
  end

  describe 'POST done' do
    it "returns http not_found if no current task" do
      Task.destroy_all

      post 'done'

      response.should be_not_found
    end

    it "returns http success if current task was done" do
      Task.create_current(
        @user,
        name: 'test task',
        tags: ['tag1','tag2'],
        estimated_seconds: 100
        )

      post 'done'

      response.should be_success
    end

    it "closes current task and no current task should be there" do
      Task.create_current(
        @user,
        name: 'test task',
        tags: ['tag1','tag2'],
        estimated_seconds: 100
        )

      post 'done'

      Task.current(@user).should be_nil
    end
  end

  describe 'POST resume' do
    it 'creates current task what was not current' do
      t = Task.create_current(
        @user,
        name: 'test task resume',
        tags: [],
        estimated_seconds: 100
      )

      t.close!

      post 'resume', {id: t._id}

      response.should be_success
      expect(Task.current @user).not_to be_nil
      expect(Task.current(@user)._id).to eq(t._id)
    end
  end

end
