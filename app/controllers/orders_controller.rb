class OrdersController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @payjp_public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    token = params[:payjpToken]

    charge = Payjp::Charge.create(
      amount: 1000, # ここに決済金額を入れてね
      card: token,
      currency: 'jpy'
    )

    if charge.paid
      flash[:notice] = "決済が完了しました！"
      redirect_to root_path
    else
      flash[:alert] = "決済に失敗しました..."
      render :index
    end
  end
end
