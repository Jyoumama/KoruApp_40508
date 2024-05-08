class ReservationsController < ApplicationController


  before_action :set_reservation, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create] # ログインが必要なアクション名を適宜追加


  def index
    @reservations = Reservation.all
    @reservations = Reservation.all.where('day >= ?', Date.current).where('day < ?', Date.current >> 3).order(day: :desc)
  end

  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    if @day.present? && @time.present?
      @start_time = DateTime.parse("#{@day} #{@time} JST")
      # end
      # if @reservation.save
      # redirect_to reservation_path @reservation.id
    else
      render :new, status: :unprocessable_entity
    end
  end

    def new
      @reservation = Reservation.new
      @day = params[:day]
      @time = params[:time]
    end

    def show
      @reservation = Reservation.find(params[:id])
      @date = params[:day]
    end

def create
  @reservation = current_user.reservations.build(reservation_params)
  @time = reservation_params[:time]

  if @time.present?
    begin
      parsed_time = Time.parse(@time)
      @reservation.start_time = DateTime.new(@reservation.day.year, @reservation.day.month, @reservation.day.day, parsed_time.hour, parsed_time.min)
    rescue ArgumentError
      # 無効な時刻形式の場合の処理
    end
  end

  if @reservation.seat_type_id == 1
    flash[:notice] = '席のタイプを選択してください。'
  else
    if @reservation.save
      redirect_to reservation_path(@reservation.id)
    else
      render :new, status: :unprocessable_entity
    end
  end
end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservation_path(@reservation.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    if @reservation.destroy
      flash[:success] = '予約を削除しました。'
      redirect_to user_path(current_user.id), status: :see_other
    else
      render :show,status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :seat_type_id)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
