require 'rails_helper'

RSpec.describe StatusesController, type: :request do
  context 'GET index' do
    it 'retuns a successful response' do
      get '/statuses'
      expect(response).to be_successful
    end

    it 'assigns statuses into the index view' do
      get '/statuses'
      expect(Status.where(replied_to_status_id: nil).includes(:user, :replies)).to eq(assigns(:statuses))
    end

    it 'renders the root template' do
      get '/statuses'
      assert_template 'statuses/index'
    end
  end

  context 'GET new' do
    it 'returns a successful response' do
      get '/statuses/new'
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get '/statuses/new'
      assert_template 'statuses/new'
    end

    it 'assigns a new status object into the view' do
      get '/statuses/new'
      expect(assigns(:status)).to be_a_kind_of(Status)
    end
  end

  context 'POST create' do
    it 'creates a new status' do
      expect{ post '/statuses', params: { status: { user_id: 1, body: 'whatever' } } }.to change { Status.count }.by(1)
    end
  end

  context 'PUT update' do
    let(:user) { User.create!(display_name: 'valid_display_name', handle: 'valid_handle', born_at: 14.years.ago) }
    let(:status) { Status.create!(body: 'valid_body', user: user) }

    it 'updates an existing status' do
      patch "/statuses/#{status.id}", params: { status: { user_id: user.id, body: 'whatever'} }
      expect(Status.find(status.id).body).to eq('whatever')
    end
  end

  context 'DELETE status' do
    let(:user) { User.create!(display_name: 'valid_display_name', handle: 'valid_handle', born_at: 14.years.ago) }
    let!(:status) { Status.create!(body: 'dfdf', user: user) }

    it 'deletes a status' do
      expect { delete "/statuses/#{status.id}" }.to change { Status.count }.by(-1)
    end
  end
end
