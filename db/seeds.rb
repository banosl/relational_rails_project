# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#States

@washington = State.create!(
  name:"Washington", 
  population:7.739, 
  gdp:492.63, 
  size:71362, 
  coastal:true)
@colorado = State.create!(
  name:"Colorado", 
  population:5.812, 
  gdp:373.76, 
  size:104185, 
  coastal:false)
@california = State.create!(
  name:"California", 
  population:39.24, 
  gdp:3370, 
  size:163696, 
  coastal:true)

  #Cities

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
@republic = @washington.cities.create!(name: "Republic",
  population: 1144, 
  owner_occupied_housing_unit_rate: 47.0, 
  form_of_gov: "Mayor-Council", 
  size: 1.421, 
  median_household_income: 32639, 
  public_transit: false)  