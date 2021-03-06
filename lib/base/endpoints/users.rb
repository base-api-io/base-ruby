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
      def create(email:, password:, confirmation:, custom_data: nil)
        request do
          response =
            connection.post('',
                            'custom_data' => custom_data.to_json,
                            'confirmation' => confirmation,
                            'password' => password,
                            'email' => email)

          parse(response.body)
        end
      end

      # Updates a user with the given data.
      def update(id:, email:, custom_data: nil)
        request do
          response =
            connection.post(id,
                            'custom_data' => custom_data.to_json,
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
