class StatesController < ApplicationController
  def index
    @states = State.all.order(created_at: :desc)
  end

  def show
    @state = State.find(params[:id])
  end

  def new
  end

  def create
    state = State.new({
      name: params[:State][:name],
      population: params[:State][:population],
      gdp: params[:State][:gdp],
      size: params[:State][:size],
      coastal: params[:State][:coastal]
    })

    state.save

    redirect_to '/states'
  end

  def edit
    @state = State.find(params[:id])
  end
end