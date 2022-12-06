require 'rails_helper'

RSpec.describe "States Edit", type: :feature do
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
    end
    
    it "has fields for updating the state " do
        visit "/states/#{@washington.id}/edit"

        expect(page).to have_field(:name)
        expect(page).to have_field(:population)
        expect(page).to have_field(:gdp)
        expect(page).to have_field(:size)
        expect(page).to have_field(:coastal)
    end

    it "a state's info is updated and user is redirected to the state's show page" do
      visit "/states/#{@washington.id}/edit"
      fill_in :size, with: '121325.64'
      choose :coastal, with: "false"
      click_button 'Edit State'

      expect(page).to have_content("#{@washington.name}")
      expect(page).to have_content("State Size: 121325.64")
      expect(page).to have_content("Is it a coastal state?: false")
    end

end