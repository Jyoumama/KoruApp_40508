class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :seat_type

  belongs_to :user

  with_options presence: true do
    validates :day
    validates :time
    validates :start_time, uniqueness: { message: 'は他のユーザーが予約しています' }
    validates :seat_type_id, numericality: { other_than: 1, message: "can't be blank" }
  end
  validate :date_before_start
  validate :date_three_month_end

  def date_before_start
    return unless day.present?

    errors.add(:day, 'は過去の日付を選択できません。予約画面から正しい日付を選択してください。') if day < Date.current
  end

  def date_three_month_end
    errors.add(:day, 'は3ヶ月以降の日付は選択できません。予約画面から正しい日付を選択してください。') if day && ((Date.current >> 3) < day)
  end

  def self.find_reservation_day(day)
    if day < Date.current
      '過去の日付は選択できません。正しい日付を選択してください。'
    elsif (Date.current >> 3) < day
      '3ヶ月以降の日付は選択できません。正しい日付を選択してください。'
    end
  end

  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.all.where('day >= ?', Date.current).where('day < ?', Date.current >> 3).order(day: :desc)
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime('%Y-%m-%d'), time: reservation.time)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end
end
