require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    before { request.headers['Accept'] = 'application/json' }
    render_views

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when requesting page as JSON' do
      it 'renders as JSON' do
        get :index
        expect(response.body).to be_json
      end

      context 'when database has no records' do
        it 'returns an empty JSON object' do
          get :index
          expect(response.body).to be_json.with_content({})
        end
      end

      context 'when database has saved status' do
        let(:user) { build_stubbed(:user) }

        it 'returns all saved users' do
          allow(User).to receive(:all).and_return([user, user])
          get :index
          expect(response.body).to
          be_json.with_content([
                                 { 'display_name' => user.display_name },
                                 { 'display_name' => user.display_name }
                               ])
                  .at_path('users')
        end
      end
    end
  end
end
