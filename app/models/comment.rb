class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 150 }
  validates :post, presence: true
  validates :user, presence: true

  belongs_to :post
  belongs_to :user
end
