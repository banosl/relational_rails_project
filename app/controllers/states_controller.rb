class StatesController < ApplicationController
  def index
    @states = State.all.order(created_at: :desc)
  end

  def show
    @state = State.find(params[:id])
  end

  def new

  end
end