class Task
  include Mongoid::Document
  include Mongoid::TagsArentHard

  field :name, type: String
  field :estimated_seconds, type: BigDecimal

  has_many :work_times, class_name: 'TaskTime', dependent: :destroy
  taggable_with :tags

  accepts_nested_attributes_for :work_times

  def self.current
    time = TaskTime.where(:end => nil).last

    return nil unless time
    time.task
  end

  def self.create_current(attrs = {})
    # close all
    TaskTime.where(:end => nil).set(:end => DateTime.now)

    t = Task.create(attrs)
    t.work_times << TaskTime.create(start: DateTime.now)

    t
  end


  def close!
    work_times.where(:end => nil).update_all(end: DateTime.now)
  end
end

