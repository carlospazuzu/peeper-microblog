# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe StatusesController, type: :controller do
  describe 'GET index' do
    render_views

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when requesting page as JSON' do
      before { request.headers['Accept'] = 'application/json' }

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
        it 'exhibits the saved status information in the JSON format with the owner user display name' do
          user = double(User, display_name: 'valid_name')
          status = double(Status, id: 4, body: 'valid_body', user: user, replied_to_status_id: nil)
          allow(Status).to receive(:includes).and_return([status])

          get :index
          expect(response.body)
            .to be_json
            .with_content(
              id: status.id,
              body: status.body,
              display_name: status.user.display_name
            )
            .at_path('statuses.0')
        end

        context 'when the status is a reply for another status' do
          let(:reply_status) { build_stubbed(:status, replied_to_status: status) }
          let(:status) { build_stubbed(:status) }

          it "has an additional key 'reply_peep'" do
            allow(Status).to receive(:includes).and_return([status, reply_status])

            get :index
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['statuses']).to include(
              include('reply_peep' => true)
            )
          end
        end

        context 'when the status body field has more than 150 characters' do
          let(:long_body_status) { build_stubbed(:status_with_long_body) }

          it 'exhibits the first 150 characters' do
            allow(Status).to receive(:includes).and_return([long_body_status])

            get :index
            expect(response.body).to be_json.with_content("#{long_body_status.body[0...150]}...").at_path('statuses.0.body')
          end

          it "creates a new field named 'full_body' with the whole message" do
            allow(Status).to receive(:includes).and_return([long_body_status])

            get :index
            expect(response.body).to be_json.with_content(long_body_status.body).at_path('statuses.0.full_body')
          end
        end
      end
    end
  end

  describe 'GET show' do
    render_views

    it 'returns http success' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end

    context 'when requesting page as JSON' do
      before { request.headers['Accept'] = 'application/json' }

      it 'renders as JSON' do
        get :show, params: { id: 1 }
        expect(response.body).to be_json
      end

      context 'when database has no records' do
        it 'returns an empty JSON object' do
          get :show, params: { id: 1 }
          expect(response.body).to be_json.with_content({})
        end
      end

      context 'when database has saved status' do
        let(:found_status) { build_stubbed(:status, body: 'Whatever...') }
        let(:media) { build_stubbed(:medium) }
        let(:media_att_status) { build_stubbed(:status, media: [media]) }

        it 'fetches and shows the requested information' do
          allow(Status).to receive(:find).with(found_status.id.to_s).and_return(found_status)
          get :show, params: { id: found_status.id }
          expect(response.body).to be_json.with_content('Whatever...').at_path('status.body')
        end

        it 'shows the amount of attached media in the status' do
          allow(Status).to receive(:find).with(media_att_status.id.to_s).and_return(media_att_status)
          get :show, params: { id: media_att_status.id }
          expect(response.body).to be_json.with_content(1).at_path('status.media')
        end
      end

      context 'when non-existent id is passed' do
        it 'returns a 404 error' do
          get :show, params: { id: -1 }
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
