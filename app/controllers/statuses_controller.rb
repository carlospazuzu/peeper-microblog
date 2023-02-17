class StatusesController < ApplicationController
  before_action :set_status, only: %i[edit update show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  def index
    respond_to do |format|
      format.html { @statuses = Status.where(replied_to_status_id: nil).includes(:user, :replies) }
      format.json { @statuses = Status.includes(:user) }
    end
  end

  def new
    @parent_status_id = params[:parent_status_id]
    @status = Status.new
    4.times { @status.media.build }
  end

  def create
    @status = StatusManager::StatusCreatorService.call(status_params)

    if @status.valid?
      redirect_to root_path
    else
      @parent_status_id = params[:parent_status_id]
      render :new
    end
  end

  def edit
    @parent_status_id = params[:parent_status_id]
  end

  def update
    if @status.update(status_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @status.destroy
    redirect_to root_path
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def show_errors
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false }
      format.json { render json: { 'error': 'Record not Found!' }, status: :not_found }
    end
  end

  def status_params
    params.require(:status).permit(:user_id, :body, :replied_to_status_id, media_attributes: %i[id kind url])
  end
end
