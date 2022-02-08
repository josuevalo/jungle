require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations for Users' do

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

  end
end



