# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for sending emails.
    class Emails < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'emails'
        super
      end

      # Lists the emails of a project
      def list(page: 1, per_page: 10)
        request do
          response =
            connection.get('', per_page: per_page, page: page)

          parse(response.body)
        end
      end

      # Sends an email with the given parameters.
      #
      # If there is no sending domain set up all emails will use the
      # `proxy@base-api.io` sender and ignore the given one, also in this case
      # there is a rate limit which is 30 emails in an hour.
      #
      # If there is a sending domain, the sender must match that domain
      # otherwise it will return an error.
      def send(subject:, from:, to:, html: nil, text: nil)
        request do
          response =
            connection.post('',
                            'from' => from,
                            'to' => to,
                            'subject' => subject,
                            'html' => html,
                            'text' => text)

          parse(response.body)
        end
      end
    end
  end
end
