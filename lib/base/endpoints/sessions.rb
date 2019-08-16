# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains a method for authenticating a user.
    class Sessions < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'sessions'
        super
      end

      # Tries to authenticate (log in) the user with email and password.
      #
      # For security reasons if the email address is not registered or the
      # password is incorrect, "INVALID_CREDENTIALS" error will be returned.
      def authenticate(email:, password:)
        request do
          response =
            connection.post('',
                            'password' => password,
                            'email' => email)

          parse(response.body)
        end
      end
    end
  end
end
