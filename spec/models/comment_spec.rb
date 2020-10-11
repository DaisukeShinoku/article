require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'association' do
    describe 'belongs_to' do
      it { is_expected.to belong_to(:post) }
      it { is_expected.to belong_to(:user) }
    end
  end

  context 'with valid user & with valid post' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
    end

    it 'valid with content' do
      comment = Comment.new(
        user_id: @user.id,
        post_id: @post.id,
        content: 'content'
      )
      expect(comment).to be_valid
    end

    it 'invalid with empty content' do
      comment = Comment.new(
        user_id: @user.id,
        post_id: @post.id
      )
      expect(comment).not_to be_valid
    end
  end

  context 'without user & with valid post' do
    before do
      @post = FactoryBot.create(:post)
    end

    it 'invalid with content' do
      comment = Comment.new(
        post_id: @post.id,
        content: 'content'
      )
      expect(comment).not_to be_valid
    end

    it 'invalid with empty content' do
      comment = Comment.new(
        post_id: @post.id
      )
      expect(comment).not_to be_valid
    end
  end

  context 'with valid user & without post' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'invalid with content' do
      comment = Comment.new(
        user_id: @user.id,
        content: 'content'
      )
      expect(comment).not_to be_valid
    end

    it 'invalid with empty content' do
      comment = Comment.new(
        user_id: @user.id
      )
      expect(comment).not_to be_valid
    end
  end
end
