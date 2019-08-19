# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for uploading and managing files.
    class Files < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'files'
        super
      end

      # Uploads the given file and returns its metadata.
      def create(path:, type:, filename:)
        request do
          io =
            Faraday::UploadIO.new(path, type, filename)

          response =
            connection.post('', 'file' => io)

          parse(response.body)
        end
      end

      # Returns the publicly accessible download URL of the file with the
      # given ID.
      def download_url(id)
        "#{connection.url_prefix}#{id}/download"
      end

      # Downloads the file with the given ID into an IO.
      def download(id)
        response =
          Faraday.new(download_url(id)) do |conn|
            conn.use RaiseError
            conn.use Faraday::Adapter::NetHttp
          end.get

        io(response.body)
      end

      # Returns the metadata of the file with the given ID.
      def get(id)
        request do
          response =
            connection.get id

          parse(response.body)
        end
      end

      # Deletes the file with the given ID.
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
