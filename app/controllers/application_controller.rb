class ApplicationController < ActionController::API
    before_action :set_current_user

    private
    def set_current_user
        requester_id = 1
        @current_user = User.find_by(id: requester_id)
    end
end
