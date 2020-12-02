class CardsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index
    @teams = Team.all().order(:name)
    if params[:search]
      search_key = "players.name LIKE '#{params[:search]}%'"

      if params[:choice] != ""
        search_key = "players.name LIKE '#{params[:search]}%' AND teams.id = #{params[:choice]}"
      end

      @cards = Card.joins(:player, :team).where(search_key).page(params[:page])
    else
      @cards = Card.all.page(params[:page])
    end
  end

  def new_cards
    @teams = Team.all().order(:name)
    if params[:search]
      search_key = "players.name LIKE ? AND cards.created_at > ?", "#{params[:search]}%", Date.today - 3

      if params[:choice] != ""
        search_key = "players.name LIKE ? AND teams.id = ? AND cards.created_at > ?", "#{params[:search]}%", params[:choice], Date.today - 3
      end

      @cards = Card.joins(:player, :team).where(search_key).page(params[:page])
    else
      @cards = Card.all.where("created_at > ?", Date.today - 3).page(params[:page])
    end
  end

  def updated_cards
    @teams = Team.all().order(:name)
    if params[:search]
      search_key = "players.name LIKE ? AND cards.updated_at > ? AND cards.updated_at <> cards.created_at", "#{params[:search]}%", Date.today - 3

      if params[:choice] != ""
        search_key = "players.name LIKE ? AND teams.id = ? AND cards.updated_at > ? AND cards.updated_at <> cards.created_at",
        "#{params[:search]}%", params[:choice], Date.today - 3
      end

      @cards = Card.joins(:player, :team).where(search_key).page(params[:page])
    else
      @cards = Card.all.where("updated_at > ? AND updated_at <> created_at", Date.today - 3).page(params[:page])
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    item = {id: id, quantity: quantity}
    session[:cart] << item unless session[:cart].include?(item[:id])
    redirect_to cards_path
  end

  def remove_from_cart
    id = params[:id].to_i
    # item_to_delete = session[:cart].select {|i| i["id"] == id}
    # session[:cart].delete(item_to_delete)
    session[:cart] = session[:cart].select {|i| i["id"] != id}
    redirect_to cards_path
  end

  def edit_cart_item
    id = params[:id].to_i
    item = session[:cart].select {|i| i["id"] == id}[0]
    item["quantity"] = params[:quantity]
    redirect_to cards_path
  end

  def checkout
    @sub_total = 0

    session[:cart].each do |item|
      quantity = item["quantity"].to_i
      price = Card.find(item["id"]).price
      @sub_total += price * quantity
    end

    @gst = current_customer.province.gst * @sub_total
    @pst = current_customer.province.pst * @sub_total
    @hst = current_customer.province.hst * @sub_total

    @total = @sub_total + @gst + @pst + @hst

  end

  def place_order
    @sub_total = 0

    session[:cart].each do |item|
      quantity = item["quantity"].to_i
      price = Card.find(item["id"]).price
      @sub_total += price * quantity
    end

    @gst = current_customer.province.gst * @sub_total
    @pst = current_customer.province.pst * @sub_total
    @hst = current_customer.province.hst * @sub_total

    @total = @sub_total + @gst + @pst + @hst

    order = create_order(current_customer, @sub_total, @gst, @pst, @hst, @total)

    session[:cart].each do |item|
      card = Card.find(item["id"])
      quantity = item["quantity"]
      create_card_order(card, order, quantity)
    end

    session[:cart] = []
    session[:cart] ||= []
    load_cart
  end

  private
  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    ids = []

    session[:cart].each do |i|
      ids << i["id"]
    end

    @cart = Card.find(ids)
    @session_cart = session[:cart]
  end

  def create_card_order(card, order, quantity)
    CardOrder.create(card: card, order: order, quantity: quantity)
  end

  def create_order(customer, sub_total, gst, pst, hst, total)
    Order.create(customer: customer, status: "paid", sub_total: sub_total, gst: gst, pst: pst, hst: hst, total: total)
  end

end