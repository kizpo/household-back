class ApplicationController < ActionController::API
    before_action :authenticate_request

    # トークンを生成するメソッド
    def create_token(user_id)
        payload = { user_id: user_id }
        secret_key = Rails.application.credentials.secret_key_base
        JWT.encode(payload, secret_key)
    end

    # 認証を行うメソッド
    def authenticate_request
        authorization_header = request.headers['Authorization']
        if authorization_header.blank?
            Rails.logger.info "ヘッダー"
            render json: { errors: 'Unauthorized' }, status: :unauthorized
            return
        end

        token = authorization_header.split(' ').last
        secret_key = Rails.application.credentials.secret_key_base

        begin
            decoded_token = JWT.decode(token, secret_key).first
            @current_user = User.find(decoded_token['user_id'])
        rescue ActiveRecord::RecordNotFound => e
            Rails.logger.info "User not found: #{e.message}"
            render json: { errors: 'User not found', details: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            Rails.logger.info "JWT Decode Error: #{e.message}"
            render json: { errors: 'Unauthorized', details: e.message }, status: :unauthorized
        end
    end

    def current_user
        @current_user
    end
end
