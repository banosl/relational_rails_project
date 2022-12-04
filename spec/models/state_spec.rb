require 'rails_helper'

RSpec.describe State, type: :model do
  before :each do
    @washington = State.create!(name: "Washington", 
      population: 7.739, 
      gdp: 577.2, 
      size: 71362, 
      coastal: true)
    @colorado = State.create!(name: "Colorado", 
      population: 5.812, 
      gdp: 373.76, 
      size: 104185, 
      coastal: false)
    @california = State.create!(name: "California", 
      population: 39.24, 
      gdp: 3.37, 
      size: 163696, 
      coastal: true)
      @seattle = @washington.cities.create!(
        name: "Seattle", 
        population: 733919, 
        owner_occupied_housing_unit_rate: 44.9, 
        form_of_gov: "Mayor-Council", 
        size: 83.78, 
        median_household_income: 97185, 
        public_transit: true)
      @spokane = @washington.cities.create!(
        name: "Spokane", 
        population: 229071, 
        owner_occupied_housing_unit_rate: 56.0, 
        form_of_gov: "Mayor-Council", 
        size: 69.49, 
        median_household_income: 52600, 
        public_transit: true)
      @denver = @colorado.cities.create!(
        name: "Denver", 
        population: 711463, 
        owner_occupied_housing_unit_rate: 50.4, 
        form_of_gov: "Consolidated City-County", 
        size: 154.7, 
        median_household_income: 72661, 
        public_transit: true)
  end
  it 'state has attributes' do
    expect(@washington.name).to eq("Washington")
    expect(@washington.population).to eq(7.739)
    expect(@washington.gdp).to eq(577.2)
    expect(@washington.size).to eq(71362)
    expect(@washington.coastal).to be true
  end

  describe 'relationships' do
    it {should have_many :cities}
    
  end

  it 'can count cities for a state' do
    expect(@washington.count).to eq(2)
    expect(@colorado.count).to eq(1)
    expect(@california.count).to eq(0)
  end
end





# RSpec.describe 'The site shows a list of states' do
#   it 'displays states names' do
#     washington = State.create!(name:"Washington", population:7.739, gdp:577.2, size:71362, coastal:true)
#     colorado = State.create!(name:"Colorado", population:5.812, gdp:373.76, size:104185, coastal:true)
#     visit "/states/#{washington.id}"

#     expect(page).to have_content(washington.title)
#     expect(page).to_not have_content(colorado.title)
#   end
# end