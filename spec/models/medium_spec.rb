require 'rails_helper'

RSpec.describe Medium, type: :model do
  describe 'validations' do
    context 'kind' do
      it { is_expected.to validate_presence_of(:kind) }
    end
  end
end
