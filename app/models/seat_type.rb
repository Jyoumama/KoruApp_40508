class SeatType < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Aタイプ' },
    { id: 3, name: 'Bタイプ' },
    { id: 4, name: 'Cタイプ' },
    { id: 5, name: 'Kタイプ' }
  ]

  include ActiveHash::Associations
  has_many :reservations
end
