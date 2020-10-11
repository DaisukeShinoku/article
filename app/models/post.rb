class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :text, presence: true, length: { maximum: 2000 }
end
