class UsersController < ApplicationController
  def edit
  end

  def update
    current_user.update(user_params)
  end

  def show
    @user = User.find(current_user.id)

   
    @user_reservations = current_user.reservations.where('start_time >= ?', DateTime.current).order(day: :desc)
    @visit_historys = current_user.reservations.where('start_time < ?', DateTime.current).where('start_time > ?',
                                                                                                DateTime.current << 12).order(day: :desc)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
