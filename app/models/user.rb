class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

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

  def comfirm_friend_request(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendships.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
