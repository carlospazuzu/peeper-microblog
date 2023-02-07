require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'validations' do
    context 'body' do
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body).is_at_most(300) }
    end
  end
end
