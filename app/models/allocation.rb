class Allocation
  include Mongoid::Document

  field :name, type: String
  field :start, type: DateTime
  field :end, type: DateTime

  def create_current!(attrs = {})
    self.create! attrs
  end
end
