module Api
    module V1
        class AuthorizeApiRequest
            def self.call(headers = {})
                new(headers).call
            end

            def initialize(headers = {})
                @headers = headers
            end

            def call
                {
                    user: user
                }
            end

            private

            attr_reader :headers

            def user
                return unless decoded_token
                User.find_by(id: decoded_token[:user_id])
            end

            def decoded_token
                @decoded_token ||= JWT.decode(token, Rails.application.secret_key_base).first.symbolize_keys
            rescue
                nil
            end

            def token
                headers['Authorization']&.split(' ')&.last
            end
        end
    end
end
