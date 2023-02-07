require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'handle' do
      it { is_expected.to validate_length_of(:handle).is_at_least(4).is_at_most(12) }
      it { is_expected.not_to allow_value('carlo$$$').for(:handle) }
      it { is_expected.to validate_uniqueness_of(:handle) }
    end

    context 'display_name' do
      it { is_expected.to validate_presence_of(:display_name) }
      it { is_expected.to validate_length_of(:display_name).is_at_most(30) }
    end

    context 'bio' do
      it { is_expected.to validate_length_of(:bio).is_at_most(300) }
    end

    context 'when the user is less than 13 years old' do
      subject(:user) do
        build(:user, born_at: 3.years.ago)
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe 'associations' do
    context 'followers' do
      it { is_expected.to have_many(:followers) }
    end

    context 'followings' do
      it { is_expected.to have_many(:followings) }
    end
  end
end
