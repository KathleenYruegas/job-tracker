class Category < ApplicationRecord
  has_many :jobs
  validates_presence_of :title
end
