class TaskTime
  include Mongoid::Document

  field :start, type: DateTime
  field :end, type: DateTime
  belongs_to :task, inverse_of: :work_times
  belongs_to :user, inverse_of: :work_times

  scope :today, ->() do
    where(:start.lte => DateTime.now.to_date+1, :end.gte => DateTime.now.to_date)
  end

end
