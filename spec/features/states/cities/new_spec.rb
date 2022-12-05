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

    expect(page).to have_field("City[name]")
    expect(page).to have_field("City[population]")
    expect(page).to have_field("City[owner_occupied_housing_unit_rate]")
    expect(page).to have_field("City[form_of_gov]")
    expect(page).to have_field("City[size]")
    expect(page).to have_field("City[median_household_income]")
    expect(page).to have_field("City[public_transit]")
  end

  it "form is filled out and submitted" do
    visit "/states/#{@washington.id}/cities/new"

    fill_in "City[name]", with:"Auburn"
    fill_in "City[population]", with: 85699
    fill_in "City[owner_occupied_housing_unit_rate]", with: 59.6
    fill_in "City[form_of_gov]", with: "Mayor-Council"
    fill_in "City[size]", with: 29.87
    fill_in "City[median_household_income]", with: 76410
    fill_in "City[public_transit]", with: true

    click_button "Create City"

    expect(page.current_url).to eq("http://www.example.com/states/#{@washington.id}")
    expect(page).to have_content("Auburn")
   end
end