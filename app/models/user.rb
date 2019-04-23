class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { maximum: 20 },
             format: { with: /[a-z]+/i }
  validates :last_name, presence: true, length: { maximum: 20 },
             format: { with: /[a-z]+/i }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friend_requests_sent, foreign_key: :sender_id,
            class_name: "FriendRequest", dependent: :destroy

  has_many :friend_requests_received, foreign_key: :receiver_id,
            class_name: "FriendRequest", dependent: :destroy

  has_many :friendships, foreign_key: :user1_id, dependent: :destroy
  has_many :friendships_2, class_name: "Friendship", foreign_key: :user2_id,
            dependent: :destroy

  has_many :friends, through: :friendships, source: :user2

  def establish_friendship(other_user)
    self.friends.push(other_user)
    other_user.friends.push(self)
  end
end
