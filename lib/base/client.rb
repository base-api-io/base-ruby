# frozen_string_literal: true

require_relative 'models/crop'
require_relative 'models/resize'

require_relative 'endpoint'
require_relative 'endpoints/mailing_lists'
require_relative 'endpoints/passwords'
require_relative 'endpoints/sessions'
require_relative 'endpoints/images'
require_relative 'endpoints/emails'
require_relative 'endpoints/users'
require_relative 'endpoints/files'
require_relative 'endpoints/forms'

module Base
  # A client containing all the endpoints.
  class Client
    # Endpoint for the mailing lists
    attr_reader :mailing_lists

    # Endpoint for the forgot password flow.
    attr_reader :passwords

    # Endpoint for the sessions.
    attr_reader :sessions

    # Endpoint for the emails.
    attr_reader :emails

    # Endpoint for the images.
    attr_reader :images

    # Endpoint for the users.
    attr_reader :users

    # Endpoint for the files.
    attr_reader :files

    # Endpoint for the files.
    attr_reader :forms

    # Initializes a new client with an access_token and optional url.
    def initialize(access_token:, url: 'https://api.base-api.io')
      @users =
        Endpoints::Users.new(
          access_token: access_token,
          url: url
        )

      @files =
        Endpoints::Files.new(
          access_token: access_token,
          url: url
        )

      @images =
        Endpoints::Images.new(
          access_token: access_token,
          url: url
        )

      @sessions =
        Endpoints::Sessions.new(
          access_token: access_token,
          url: url
        )

      @emails =
        Endpoints::Emails.new(
          access_token: access_token,
          url: url
        )

      @passwords =
        Endpoints::Passwords.new(
          access_token: access_token,
          url: url
        )

      @mailing_lists =
        Endpoints::MailingLists.new(
          access_token: access_token,
          url: url
        )

      @forms =
        Endpoints::Forms.new(
          access_token: access_token,
          url: url
        )
    end
  end
end
