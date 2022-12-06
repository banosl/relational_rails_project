class City < ApplicationRecord
  belongs_to :state
  
  def self.cities_with_public_transit
    where(public_transit: :true)
  end
end