# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for handling the forgot password flow.
    class Passwords < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'password'
        super
      end

      # Generates a forgot password token for the user with the given email.
      def forgot_password(email:)
        request do
          response =
            connection.post('',
                            'email' => email)

          parse(response.body)
        end
      end

      # Sets the password of a user with the given forgot password token.
      def set_password(forgot_password_token:,
                       confirmation:,
                       password:)
        request do
          response =
            connection.put('',
                           'forgot_password_token' => forgot_password_token,
                           'confirmation' => confirmation,
                           'password' => password)

          parse(response.body)
        end
      end
    end
  end
end
