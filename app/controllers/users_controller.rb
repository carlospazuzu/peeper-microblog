class UsersController < ApplicationController
  def index
    respond_to do |format|
      format.json { @users = User.all }
    end
  end
end
