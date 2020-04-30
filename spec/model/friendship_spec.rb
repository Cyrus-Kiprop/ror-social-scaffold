require 'rails_helper'
require_relative '../../app/models/friendship.rb'
RSpec.describe Friendship do
  let(:user_one) { User.new(email: 'example@gamil.com', password:'password', name:'John Doe', gravatar_url: 'www.gravatar_john_doe.com') }

  let(:user_two) { User.new(email: 'example1@gamil.com', password:'password', name:'Erick Dier', gravatar_url: 'www.gravatar_erick_dier.com') }

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
end
