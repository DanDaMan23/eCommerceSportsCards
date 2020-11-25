class CardsController < ApplicationController
  def index
    if params[:search]
      # @cards = Card.where("brand LIKE '#{params[:search]}%'").page(params[:page])
      @cards = Card.joins(:player).where("name LIKE '#{params[:search]}%'").page(params[:page])
    else
      @cards = Card.all.page(params[:page])
    end
  end

  def new_cards
    if params[:search]
      @cards = Card.joins(:player).where("name LIKE ? AND cards.created_at > ?", "#{params[:search]}%", Date.today - 3).page(params[:page])
    else
      @cards = Card.all.where("created_at > ?", Date.today - 6).page(params[:page])
    end
  end

  def updated_cards
    if params[:search]
      @cards = Card.joins(:player).where("name LIKE ? AND cards.updated_at > ? AND cards.updated_at <> cards.created_at",
        "#{params[:search]}%", Date.today - 3).page(params[:page])
    else
      @cards = Card.all.where("updated_at > ? AND updated_at <> created_at", Date.today - 3).page(params[:page])
    end
  end

  def show
    @card = Card.find(params[:id])
  end

end