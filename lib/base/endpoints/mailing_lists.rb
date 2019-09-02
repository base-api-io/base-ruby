# frozen_string_literal: true

module Base
  module Endpoints
    # This endpoint contains methods for managing mailing lists.
    class MailingLists < Endpoint
      # Initializes this endpoint.
      def initialize(access_token:, url:)
        @path = 'mailing_lists'
        super
      end

      # Lists the mailing lists of a project
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
      def send(id:, subject:, from:, html:, text:)
        request do
          response =
            connection.post("#{id}/send",
                            'from' => from,
                            'subject' => subject,
                            'html' => html,
                            'text' => text)

          parse(response.body)
        end
      end

      # Subscribes an email to the mailing list with the given id.
      def subscribe(id:, email:)
        request do
          response =
            connection.post("#{id}/subscribe", 'email' => email)

          parse(response.body)
        end
      end

      # Unsubscribes an email from the mailing list with the given id.
      def unsubscribe(id:, email:)
        request do
          response =
            connection.post("#{id}/unsubscribe", 'email' => email)

          parse(response.body)
        end
      end

      # Returns the unsubscribe url for the given email of list the given id.
      def unsubscribe_url(id:, email:)
        token =
          Base64.encode64("#{id}:#{email}")

        "#{connection.url_prefix}unsubscribe?token=#{token}"
      end

      # Returns the metadata of the mailing list with the given ID.
      def get(id)
        request do
          response =
            connection.get id

          parse(response.body)
        end
      end
    end
  end
end
