module ReservationsHelper
  def times
    times = ["10:00",
             "10:30",
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30",
             "18:00 "]
  end
  
  def find_reservation(reservations, day, time)
    result = false
    reservations_count = reservations.count
    # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返します
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:day].eql?(day) && reservation[:time].eql?(time)
        return reservation if result
      end
    elsif reservations_count == 1
      result = reservations[0][:day].eql?(day) && reservations[0][:time].eql?(time)
      return reservations[0] if result
    end
    return result
  end
end