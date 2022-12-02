class StateCitiesController < ApplicationController
  def index
    @state = State.find(params[:state_id])
    @cities = @state.cities
  end
end