require 'rails_helper'

RSpec.describe "States New", type: :feature do
  it "has fields for a new state " do
    visit "/states/new"
    expect(page).to have_field(:name)
    expect(page).to have_field(:population)
    expect(page).to have_field(:gdp)
    expect(page).to have_field(:size)
    expect(page).to have_field(:coastal)
  end

  it "form is fill out and submitted" do
    visit "/states/new"

    fill_in :name, with: 'New Mexico'
    fill_in :population, with: '2.116'
    fill_in :gdp, with: '95.01'
    fill_in :size, with: '121697'
    choose :coastal, with: 'false'

    click_button 'Create State'
    
    expect(page.current_path).to eq("/states")
    expect(page).to have_content("New Mexico")
  end

end