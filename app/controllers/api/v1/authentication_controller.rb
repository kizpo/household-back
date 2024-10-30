module Api
    module V1
        class AuthenticationController < ApplicationController
            before_action :authenticate_request
            def login
                user = User.find_by(email: params[:email])

                if user && user.authenticate(params[:password])
                    token = encode_token({ user_id: user.id })
                    render json: { jwt: token, user: user }, status: :ok
                else
                    render json: { error: 'Invalid email or password' }, status: :unauthorized
                end
            end

            private

            def encode_token(payload)
                secret_key = Rails.application.credentials.secret_key_base
                JWT.encode(payload, secret_key)
            end

            def authenticate_request
                @current_user = AuthorizeApiRequest.call(request.headers)[:user]
            end

            def current_user
                @current_user
            end
        end
    end
end
