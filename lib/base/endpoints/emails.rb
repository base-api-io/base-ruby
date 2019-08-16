# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for sending emails.
    class Emails < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'email'
        super
      end

      # Sends an email with the given parameters.
      #
      # If there is no sending domain set up all emails will use the
      # `proxy@base-api.io` sender and ignore the given one, also in this case
      # there is a rate limit which is 30 emails in an hour.
      #
      # If there is a sending domain, the sender must match that domain
      # otherwise it will return an error.
      def send(subject:, from:, html:, text:, to:)
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
