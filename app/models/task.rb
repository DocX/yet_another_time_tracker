class Task
  include Mongoid::Document
  include Mongoid::TagsArentHard

  field :name, type: String
  field :estimated_seconds, type: BigDecimal

  has_many :work_times, class_name: 'TaskTime', dependent: :destroy
  taggable_with :tags

  belongs_to :user, :inverse_of => :tasks

  accepts_nested_attributes_for :work_times

  def self.current(user)
    time = TaskTime.where(:user=> user, :end => nil).last

    return nil unless time
    time.task
  end

  def self.create_current(user, attrs = {})
    # close all
    TaskTime.where(:user=> user, :end => nil).set(:end => DateTime.now)

    t = Task.create(attrs.merge(:user => user))
    t.work_times << TaskTime.create(start: DateTime.now, :user => user)

    t
  end


  def close!
    work_times.where(:end => nil).update_all(end: DateTime.now)
  end

  # closes all other tasks and makes this now current
  def resume!
    self.class.current(self.user).close! if self.class.current(self.user)
    self.work_times << TaskTime.create(start: DateTime.now, user: self.user)

    self
  end
end

