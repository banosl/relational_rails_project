class State < ApplicationRecord
  has_many :cities

  def count
    self.cities.count
  end
end