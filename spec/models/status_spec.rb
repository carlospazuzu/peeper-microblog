require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'validations' do
    context 'body' do
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body).is_at_most(300) }
    end
  end

  describe 'associations' do
    context 'replies' do
      it { is_expected.to have_many(:replies) }
    end

    context 'user' do
      it { is_expected.to belong_to(:user) }
    end

    context 'media' do
      it 'is expected to not allow more than 4 medium objects to be attached' do
        status = Status.new(body: 'whatever')
        5.times do
          status.media << Medium.new(kind: 1, url: 'https://google.com/img.png')
        end
        is_expected.not_to be_valid
      end
    end
  end
end
