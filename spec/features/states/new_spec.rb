require 'rails_helper'

RSpec.describe "States New", type: :feature do
  it "has fields for a new state " do
    visit "/states/new"
    expect(page).to have_field("State[name]")
    expect(page).to have_field("State[population]")
    expect(page).to have_field("State[gdp]")
    expect(page).to have_field("State[size]")
    expect(page).to have_field("State[coastal]")
  end

  it "form is fill out and submitted" do
    visit "/states/new"

    fill_in 'State[name]', with: 'New Mexico'
    fill_in 'State[population]', with: '2.116'
    fill_in 'State[gdp]', with: '95.01'
    fill_in 'State[size]', with: '121697'
    fill_in 'State[coastal]', with: 'false'

    click_button 'Create State'
    
    expect(page.current_url).to eq("http://www.example.com/states")
    expect(page).to have_content("New Mexico")
  end

end