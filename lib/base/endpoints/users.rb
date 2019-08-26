# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for creating and managing users.
    class Users < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'users'
        super
      end

      # Lists the files of a project
      def list(page: 1, per_page: 10)
        request do
          response =
            connection.get('', per_page: per_page, page: page)

          parse(response.body)
        end
      end

      # Creates a user with the given credentials.
      def create(email:, password:, confirmation:)
        request do
          response =
            connection.post('',
                            'confirmation' => confirmation,
                            'password' => password,
                            'email' => email)

          parse(response.body)
        end
      end

      # Gets the details of the user with the given ID.
      def get(id)
        request do
          response =
            connection.get id

          parse(response.body)
        end
      end

      # Deletes the user with the given ID.
      def delete(id)
        request do
          response =
            connection.delete id

          parse(response.body)
        end
      end
    end
  end
end
