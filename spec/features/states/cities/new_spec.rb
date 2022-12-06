require 'rails_helper'

RSpec.describe "State Add New City" do
  before :each do
    @washington = State.create!(name: "Washington", 
        population: 7.739, 
        gdp: 492.63, 
        size: 71362, 
        coastal: true)
  end
  it "has fields for a new city" do
    visit "/states/#{@washington.id}/cities/new"

    expect(page).to have_field(:name)
    expect(page).to have_field(:population)
    expect(page).to have_field(:owner_occupied_housing_unit_rate)
    expect(page).to have_field(:form_of_gov)
    expect(page).to have_field(:size)
    expect(page).to have_field(:median_household_income)
    expect(page).to have_field(:public_transit)
  end

  it "form is filled out and submitted" do
    visit "/states/#{@washington.id}/cities/new"

    fill_in :name, with:"Auburn"
    fill_in :population, with: 85699
    fill_in :owner_occupied_housing_unit_rate, with: 59.6
    fill_in :form_of_gov, with: "Mayor-Council"
    fill_in :size, with: 29.87
    fill_in :median_household_income, with: 76410
    choose :public_transit, option: "true"

    click_button "Create City"

    expect(page.current_path).to eq("/states/#{@washington.id}")
    expect(page).to have_content("Auburn")
   end
end