class ApplicationController < ActionController::API
    before_action :set_current_user
    SECRET_KEY = "test"

    private
    def set_current_user
      token = request.headers['Authorization'].split("Bearer ").second rescue nil
      if token
        begin
          decoded_token = JWT.decode(token, SECRET_KEY, false, algorithm: 'HS256')
          user_id = decoded_token[0]['user_id']
          @current_user = User.find(user_id)
        rescue JWT::DecodeError
          render json: { error: 'Invalid token' }, status: :unauthorized
        end
      else
        render json: { error: 'Token missing' }, status: :unauthorized
      end
    end
end
