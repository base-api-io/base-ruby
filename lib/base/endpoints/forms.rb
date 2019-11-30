# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for forms.
    class Forms < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'forms'
        super
      end

      # Lists the forms of a project
      def list(page: 1, per_page: 10)
        request do
          response =
            connection.get('', per_page: per_page, page: page)

          parse(response.body)
        end
      end

      # Creates a form with the given name
      def create(name:)
        request do
          response =
            connection.post('', 'name' => name)

          parse(response.body)
        end
      end

      # Returns the form with the given ID.
      def get(id)
        request do
          response =
            connection.get id

          parse(response.body)
        end
      end

      # Deletes the form with the given ID.
      def delete(id)
        request do
          response =
            connection.delete id

          parse(response.body)
        end
      end

      # Submits a new submission for the form with the given ID.
      def submit(id:, form:)
        request do
          payload =
            form.each_with_object({}) do |(key, value), memo|
              memo[key] =
                case value
                when File, Tempfile
                  Faraday::UploadIO.new(
                    value.path,
                    File.mime_type?(value),
                    File.basename(value)
                  )
                else
                  value
                end
            end

          response =
            connection.post("#{id}/submit", payload)

          parse(response.body)
        end
      end

      # Returns the submission for the form with the given ID.
      def submissions(id:,
                      page: 1,
                      per_page: 10)
        request do
          response =
            connection.get("#{id}/submissions", per_page: per_page, page: page)

          parse(response.body)
        end
      end

      # Returns the submission with the given ID of the form with the given ID.
      def get_submission(id, submission_id)
        request do
          response =
            connection.get "#{id}/submissions/#{submission_id}"

          parse(response.body)
        end
      end

      # Submits a new submission for the form with the given ID.
      def update_submission(id:, form_id:, form:)
        request do
          payload =
            form.each_with_object({}) do |(key, value), memo|
              memo[key] =
                case value
                when File, Tempfile
                  Faraday::UploadIO.new(
                    value.path,
                    File.mime_type?(value),
                    File.basename(value)
                  )
                else
                  value
                end
            end

          response =
            connection.put("#{form_id}/submit/#{id}", payload)

          parse(response.body)
        end
      end

      # Deletes the submission with the given ID of the form with the given ID.
      def delete_submission(id, submission_id)
        request do
          response =
            connection.delete "#{id}/submissions/#{submission_id}"

          parse(response.body)
        end
      end
    end
  end
end
