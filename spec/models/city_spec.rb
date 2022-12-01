require 'rails_helper'

RSpec.describe City, type: :model do
  it 'city has attributes' do
    seattle = City.create!(name: "Seattle", 
        population: 733919, 
        owner_occupied_housing_unit_rate: 44.9, 
        form_of_gov: "Mayor-Council", 
        size: 83.78, 
        median_household_income: 97185, 
        public_transit: true)
binding.pry
    expect(seattle.name).to eq("Seattle")
    expect(seattle.population).to eq(733919)
    expect(seattle.owner_occupied_housing_unit_rate).to eq(44.9)
    expect(seattle.form_of_gov).to eq("Mayor-Council")
    expect(seattle.size).to eq(83.78)
    expect(seattle.median_household_income).to eq(97185)
    expect(seattle.public_transit).to be(true)
  end
end