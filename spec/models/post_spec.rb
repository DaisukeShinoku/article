require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'valid with title, test' do
    post = Post.new(
      title: 'title',
      text: 'text'
    )
    expect(post).to be_valid
  end

  it 'invalid with empty title' do
    post = Post.new(text: 'text')
    expect(post).not_to be_valid
  end

  it 'invalid with empty text' do
    post = Post.new(title: 'title')
    expect(post).not_to be_valid
  end

  it 'invalid with too long title' do
    post = Post.new(
      title: 'a' * 101,
      text: 'text'
    )
    expect(post).not_to be_valid
  end

  it 'invalid with too long text' do
    post = Post.new(
      title: 'title',
      text: 'a' * 2001
    )
    expect(post).not_to be_valid
  end

  describe 'association' do
    describe 'has_many' do
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end
  end
end
