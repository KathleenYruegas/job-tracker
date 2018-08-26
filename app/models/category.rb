class Category < ApplicationRecord
  has_many :jobs, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
