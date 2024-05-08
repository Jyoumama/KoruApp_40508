class OrdersController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
  end

  def create
  end
end
