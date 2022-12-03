require 'rails_helper'

RSpec.describe "States Index", type: :feature do
  describe "As a visitor when I visit '/states'" do
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
    end
    
    it "see the name of each state record in the system" do
      
      visit '/states'
      # save_and_open_page

      expect(page).to have_content(@washington.name)
      expect(page).to have_content(@colorado.name)
      expect(page).to have_content(@california.name)
      expect(page).to_not have_content("New York")
    end

    it "records are ordered by most recently created first" do
      visit '/states'
      save_and_open_page
binding.pry
      expect(page.body.index("California") < page.body.index("Washington")).to be(true)
    end
  end
end