class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @reservation = Reservation.find(params[:reservation_id])
    @payjp_public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    token = params[:payjpToken]
    amount = params[:amount].to_i
    reservation_id = params[:reservation_id]
    user_id = current_user.id # Assuming you have a method to get the current logged-in user

   begin
    charge = Payjp::Charge.create(
      amount: amount,
      card: token,
      currency: 'jpy'
    )

    if charge.paid
      Order.create(
        amount: amount,
        payjp_token: token,
        reservation_id: reservation_id,
        user_id: user_id
      )
      flash[:notice] = "決済が完了しました。"
      redirect_to root_path
    else
      flash[:alert] = "決済に失敗しました。"
      render :index
    end
    rescue Payjp::PayjpError => e
      flash[:alert] = e.message
      render :index
    end
  end
end


