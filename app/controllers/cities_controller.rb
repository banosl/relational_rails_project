class CitiesController < ApplicationController
  def index
    @cities= City.all
  end
  
  def show
    @city = City.find(params[:id])
  end

  def edit
    @city = City.find(params[:id])
  end
  
  def update
    city = City.find(params[:id])
    
    city.update(city_params)
    
    city.save
    redirect_to "/cities/#{city.id}"
  end

private
  def city_params
    params.require(:City).permit(:name, 
                  :population, 
                  :owner_occupied_housing_unit_rate, 
                  :form_of_gov, 
                  :size, 
                  :median_household_income, 
                  :public_transit)
  end
end