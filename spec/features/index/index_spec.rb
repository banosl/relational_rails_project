require 'rails_helper'

RSpec.describe "States Index" do
  describe "As a visitor when I visit '/states'" do
    it "see the name of each state record in the system" do
      washington = State.create!(name:"Washington", 
                                 population:7.739, 
                                 gdp:577.2, 
                                 size:71362, 
                                 coastal:true)
      colorado = State.create!(name:"Colorado", 
                               population:5.812, 
                               gdp:373.76, 
                               size:104185, 
                               coastal:false)
      california = State.create!(name:"California", 
                               population:39.24, 
                               gdp:3.37, 
                               size:163696, 
                               coastal:true)
      visit '/states'
      save_and_open_page

      expect(page).to have_content("Washington")
      expect(page).to have_content("Colorado")
      expect(page).to have_content("California")
      expect(page).to_not have_content("New York")
    end
  end
end