class Stock < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :category, presence: true
  validates :foods_name, presence: true
  validates :number, presence: true
  validates :limit, presence: true
end
