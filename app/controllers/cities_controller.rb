class CitiesController < ApplicationController
  def index
    public_transit = params[:public_transit]
    @cities = City.all
    @cities = City.where(public_transit: :true) if public_transit == "true"
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

  def destroy
    City.destroy(params[:id])

    redirect_to("/cities")
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