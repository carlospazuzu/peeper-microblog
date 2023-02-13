module StatusManager
  class StatusCreatorService < ApplicationService
    def initialize(form_params)
      @params = form_params
    end

    def call
      Status.create(@params)
    end
  end
end
