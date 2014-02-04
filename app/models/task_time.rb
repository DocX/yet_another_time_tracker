class TaskTime
  include Mongoid::Document

  field :start, type: DateTime
  field :end, type: DateTime
  belongs_to :task, inverse_of: :work_times

end
