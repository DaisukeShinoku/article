require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valid with title, test' do
    user = User.new(
      email: 'user@user.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  it 'invalid with empty password' do
    user = User.new(email: 'user@user.com')
    expect(user).not_to be_valid
  end

  it 'invalid with empty email' do
    user = User.new(password: 'password')
    expect(user).not_to be_valid
  end

  it 'invalid with invalid email' do
    user = User.new(
      email: 'hoge',
      password: 'password'
    )
    expect(user).not_to be_valid
  end

  describe 'association' do
    describe 'has_many' do
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end
  end
end
