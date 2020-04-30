class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :friend_id

  def friends
    direct_friends = friendships.map { |friendship| friendship.friend if frienship.confirmed }
    inverse_friends = inverse_friendships.map { |friendship| friendship.user if frienship.confirmed }
    (direct_friends + inverse_friends).compact
  end

  def pending_friend_requests
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def incoming_friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend_request?(user)
    friend = inverse_friendships.find { |friendship| friendship.user == user }
    if friend
      friend.confirmed = true
      friend.save
      true
    else
      false
    end
  end

  def friend?(user)
    friends.include?(user)
  end
end
