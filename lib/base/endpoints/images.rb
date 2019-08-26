# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for uploading and managing images.
    class Images < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'images'
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

      # Uploads the given image and returns its metadata.
      #
      # Only images with ImageMagick understands can be uploaded otherwise it
      # will raise an error.
      def create(path:, type:, filename:)
        request do
          io =
            Faraday::UploadIO.new(path, type, filename)

          response =
            connection.post('', 'image' => io)

          parse(response.body)
        end
      end

      # Returns the image url of the image with the given ID.
      #
      # It is possible to crop and resize the image and change its format
      # and quality.
      def image_url(id,
                    quality: nil,
                    resize: nil,
                    format: nil,
                    crop: nil)
        params = {}

        quality && params[:quality] = quality.to_s
        format && params[:format] = format.to_s
        resize && params[:resize] = resize.to_s
        crop && params[:crop] = crop.to_s

        "#{connection.url_prefix}#{id}/version?#{URI.encode_www_form(params)}"
      end

      # Downloads the image with the given ID.
      #
      # It is possible to crop and resize the image and change its format
      # and quality.
      def download(id,
                   quality: nil,
                   resize: nil,
                   format: nil,
                   crop: nil)
        url =
          image_url(id, quality: quality,
                        resize: resize,
                        format: format,
                        crop: crop)

        response =
          Faraday.new(url) do |conn|
            conn.use RaiseError
            conn.use Faraday::Adapter::NetHttp
          end.get

        io(response.body)
      end

      # Returns the metadata of the image with the given ID.
      def get(id)
        request do
          response =
            connection.get id

          parse(response.body)
        end
      end

      # Deletes the image with the given ID.
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
