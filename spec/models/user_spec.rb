require 'spec_helper'

describe User do
  it 'should destroy all users tasks when user is destroyed' do
    u = User.create :name => 'test user'

    u.tasks << Task.create(:name => 'test task')

    uid = u._id
    u.destroy

    expect(Task.where(:user => uid).count).to eq(0)
  end

end
