require 'rails_helper'

RSpec.describe "States Index", type: :feature do
  describe "As a visitor when I visit '/states'" do
    before :each do
      @washington = State.create!(name: "Washington", 
        population: 7.739, 
        gdp: 492.63, 
        size: 71362, 
        coastal: true)
      @colorado = State.create!(name: "Colorado", 
        population: 5.812, 
        gdp: 373.76, 
        size: 104185, 
        coastal: false)
      @california = State.create!(name: "California", 
        population: 39.24, 
        gdp: 3370, 
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
    
    it "see the name of each state record in the system" do
      visit '/states'

      expect(page).to have_content(@washington.name)
      expect(page).to have_content(@colorado.name)
      expect(page).to have_content(@california.name)
      expect(page).to_not have_content("New York")
    end

    it "records are ordered by most recently created first" do
      visit '/states'
      expect(page.body.index("California") < page.body.index("Washington")).to be(true)
    end

    it "see a link at the top of the page that goes to cities index" do
      visit "/states"
      expect(page).to have_link("All Cities", :href => "/cities")
    end

    it "see a link to create a new state record, 'Add State'" do
      visit "/states"
      expect(page).to have_link("Add State", :href => "/states/new")
    end

    it "when 'Add State' link is clicked user is taken to a /states/new" do
      visit "/states"
      click_link "Add State"

      expect(page.current_path).to eq("/states/new")
      expect(page).to have_content("Add a New State Record")
    end

    it "Next to every state there is a link to edit the state's info" do
      visit "/states"

      expect(page).to have_link("Edit", :href => "/states/#{@washington.id}/edit")
      expect(page).to have_link("Edit", :href => "/states/#{@colorado.id}/edit")
      expect(page).to have_link("Edit", :href => "/states/#{@california.id}/edit")
    end

    it "When edit link is clicked user is taken to the state's edit page" do
      visit "/states"
      click_link "Edit", :href => "/states/#{@washington.id}/edit"

      expect(current_path).to eq("/states/#{@washington.id}/edit")
    end

    it "Next to every state there is a link to delete that state" do
      visit "/states"

      expect(page).to have_link("Delete #{@washington.name}")
    end

    it "When delete is clicked the state is removed and user is redirected to states index page and see that the state is gone" do
      visit "/states"
      click_link "Delete #{@washington.name}"

      expect(current_path).to eq("/states")
      expect(page).to_not have_content("Washington")
    end
  end
end