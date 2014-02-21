class TaskTime
  include Mongoid::Document

  field :start, type: DateTime
  field :end, type: DateTime
  belongs_to :task, inverse_of: :work_times
  belongs_to :user, inverse_of: :work_times

  scope :today, ->() do
    between(DateTime.now.to_date, DateTime.now.to_date + 1)
  end

  scope :not_running, ->() do
    where(:end.ne => nil)
  end

  scope :between, ->(from, to) do
    self.and(:start.lte => to, :'$or' => [{:end.gte => from},{ :end => nil}])
  end

end
