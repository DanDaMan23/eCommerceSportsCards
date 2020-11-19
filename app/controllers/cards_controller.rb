class CardsController < ApplicationController
  def index
    if params[:search]
      @cards = Card.where("brand LIKE '%#{params[:search]}%'").page(params[:page])
    else
      @cards = Card.all.page(params[:page])
    end
  end

  def show
    @card = Card.find(params[:id])
  end
end
