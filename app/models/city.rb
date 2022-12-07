class City < ApplicationRecord
  belongs_to :state
  
  def self.cities_with_public_transit
    where(public_transit: :true)
  end

  def self.cities_alphabetically
    self.order(:name)
  end

  def self.city_size_query(miles_squared)
    where("size > #{miles_squared}")
  end
end