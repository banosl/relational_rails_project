require 'rails_helper'

RSpec.describe "States Show", type: :feature do
  describe "When I visit '/states/:id'" do
    it "see the state with that id including the parent's attributes" do
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

        visit "/states/#{washington.id}"
        # save_and_open_page

        expect(page).to have_content(washington.name)
        expect(page).to have_content(washington.population)
        expect(page).to have_content(washington.gdp)
        expect(page).to have_content(washington.size)
        expect(page).to have_content(washington.coastal)
        expect(page).to_not have_content(california.name)
        expect(page).to_not have_content(colorado.population)
    end
  end
end