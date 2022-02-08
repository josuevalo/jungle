require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'saves correctly having all valid fields' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      expect(@user.errors.full_messages).to be_empty
    end

    it 'checks that password and password confirmation fields match' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      expect(@user.errors.full_messages).to be_empty
    end

    it 'cannot create user because password and password confirmation fields do not match' do
      @user = User.create(password: 'jungle', password_confirmation: 'jun', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

        it 'cannot create user because email is not unique' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = @user.dup
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
    
    it 'cannot create user because email is not unique (case sensitive test)' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junGleBOok@jungle.com', first_name: 'Bal', last_name: 'oo')
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it 'checks that first name cannot be blank' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: nil, last_name: 'oo')
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'checks that last name cannot be blank' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'bal', last_name: nil)
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'checks that email cannot be blank' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: nil, first_name: 'bal', last_name: 'oo')
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'checks the password has a minimum length of 6 characters' do
      @user = User.create(password: 'jung', password_confirmation: 'jung', email: 'junglebook@jungle.com', first_name: 'bal', last_name: 'oo')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'cannot create user because email is not unique (space around test)' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.create(password: 'jungle', password_confirmation: 'jungle', email: '  junglebook@jungle.com  ', first_name: 'Bal', last_name: 'oo')
      expect(@user2.errors.full_messages).to include "Email is invalid"
    end


  end

  describe '.authenticate_with_credentials' do
    it 'should return a user if valid email and password are entered' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user2.to_json).to eq(@user.to_json)
    end

    it 'does not return a user if invalid email and password are entered' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.authenticate_with_credentials('thisiswrong', @user.password)
      expect(@user2.to_json).not_to eql(@user.to_json)
    end

    it 'should return a user even if whitespace is around email' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.authenticate_with_credentials('  junglebook@jungle.com  ', @user.password)
      expect(@user2.to_json).to eq(@user.to_json)
    end

    it 'should return a user even if email is typed in a different case' do
      @user = User.create(password: 'jungle', password_confirmation: 'jungle', email: 'junglebook@jungle.com', first_name: 'Bal', last_name: 'oo')
      @user2 = User.authenticate_with_credentials('JungleBook@JUNgle.com', @user.password)
      expect(@user2.to_json).to eq(@user.to_json)
    end

  end
end



