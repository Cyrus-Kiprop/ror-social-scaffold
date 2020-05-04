require 'rails_helper'
# require_relative '../../app/models/friendship.rb'

RSpec.describe 'User' do
  let(:user_one) { User.new(email: 'example@gamil.com', password: 'password', name: 'John Doe', gravatar_url: 'www.gravatar_john_doe.com') }

  let(:user_two) { User.new(email: 'example1@gamil.com', password: 'password', name: 'Erick Dier', gravatar_url: 'www.gravatar_erick_dier.com') }

  describe 'validation test' do
    describe 'name'
    it 'should be present' do
      user_one.name = ''
      expect(user_one).to_not be_valid
    end

    it 'should be valid when the name exist' do
      user_two.name = 'Erick Dier'
      expect(user_two).to be_valid
    end
    describe 'email' do
      it 'should be present' do
        user_one.email = ''
        expect(user_one).to_not be_valid
      end

      it 'should be valid if the email is present' do
        expect(user_two).to be_valid
      end
    end

    describe 'password' do
      it 'should be present' do
        user_one.password = ''
        expect(user_one).to_not be_valid
      end

      it 'should be valid if the password is present' do
        expect(user_two).to be_valid
      end

      it 'should have a minimum of six characters' do
        user_one.password = 'a' * 4
        expect(user_one).to_not be_valid
      end

      it 'should be valid when the password has a minimum length of 6 characters' do
        user_one.password = 'a' * 10
        expect(user_one).to be_valid
      end
    end
  end

  describe 'User helper methods' do
    describe 'friends' do
      it 'should return an array containing all the friends of a current user' do
        expect(user_one.friends.class).to eql(Array)
      end
    end

    describe 'pending_friend_requests' do
      it 'should return an array containing all the pending friends  request of a current user' do
        expect(user_one.pending_friend_requests.class).to eql(Array)
      end
    end

    describe 'incoming_friend_requests' do
      it 'should return an array containing all the incoming friends  request of a current user' do
        expect(user_one.incoming_friend_requests.class).to eql(Array)
      end
    end

    describe 'confirm_friend_request?' do
      it 'should return a boolean value indicating whether a friend request confirmation was successful or not' do
        expect(user_one.confirm_friend_request?(user_two)).to be_in([true, false])
      end
    end

    describe 'friend?' do
      it 'should return a boolean value indicating whether the user in question is a friend or not' do
        expect(user_one.friend?(user_two)).to be_in([true, false])
      end
    end
  end
end
