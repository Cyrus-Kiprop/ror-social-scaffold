class Friendship < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  belongs_to :user
  belongs_to :friend, class_name: :User

  def unique_friendship?(current_user, id)
    return false if Friendship.where('user_id = (:fid) AND friend_id =(:sid) OR user_id = (:sid) AND friend_id = (:fid)', fid: current_user.id, sid: id).exists? | no_request_to_yourself(current_user.id, id)

    new_request = current_user.friendships.build(confirmed: false, friend_id: id)
    return true if new_request.save

    false
  end

  def no_request_to_yourself(current_user_id, id)
    return true if current_user_id == id

    false
  end
end
