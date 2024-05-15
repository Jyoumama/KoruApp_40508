class OrdersController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @payjp_public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
  end
end
