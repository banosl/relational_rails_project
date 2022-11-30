require 'rails_helper'

RSpec.describe State, type: :model do
  it 'state has attributes' do
    washington = State.create!(name:"Washington", population:7.739, gdp:577.2, size:71362, coastal:true)

    expect(washington.name).to eq("Washington")
    expect(washington.population).to eq(7.739)
    expect(washington.gdp).to eq(577.2)
    expect(washington.size).to eq(71362)
    expect(washington.coastal).to be true
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