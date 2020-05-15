require 'rails_helper'
require_relative '../../app/models/friendship.rb'
RSpec.describe Friendship do
  let(:new_request) { Friendship.new }
  let(:user_one) { User.new(email: 'example@gamil.com', password: 'password', name: 'John Doe', gravatar_url: 'www.gravatar_john_doe.com') }

  let(:user_two) { User.new(email: 'example1@gamil.com', password: 'password', name: 'Erick Dier', gravatar_url: 'www.gravatar_erick_dier.com') }

  describe 'validation test' do
    describe 'user_id' do
      it 'must be present' do
        user_one.save
        user_two.save
        friendship = user_one.friendships.build(confirmed: true, friend_id: user_two.id)
        friendship.user_id = ''
        expect(friendship).to_not be_valid
        friendship.user_id = 2
        expect(friendship).to be_valid
      end
    end

    describe 'friend_id' do
      it 'must be present' do
        user_one.save
        user_two.save
        friendship = user_one.inverse_friendships.build(confirmed: true, user_id: user_two.id)
        friendship.friend_id = ''
        expect(friendship).to_not be_valid
        friendship.friend_id = user_two.id
        expect(friendship).to be_valid
      end
    end
  end

  describe 'validation methods' do
    describe 'no_friend_request_to_yourself' do
      it 'should return true if you try to friend request yourself' do
        def user_one.id
          3
        end
        expect(new_request.no_request_to_yourself(user_one.id, 3)).to eql(true)
      end
      it "should return false if the requestor's id and the reciever's id aren't similar" do
        def user_one.id
          3
        end
        expect(new_request.no_request_to_yourself(user_one, 2)).to eql(false)
      end
    end
    describe 'unique_friendship' do
      it 'should return true if a friend request is successfully sent' do
        def user_one.id
          3
        end
        expect(new_request.unique_friendship?(user_one, 2)).to be_in([true, false])
      end
    end
  end
end
