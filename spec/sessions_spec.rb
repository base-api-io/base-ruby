# frozen_string_literal: true

describe Base do
  context 'Sessions' do
    it 'authenticates a user' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/sessions/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            email: 'test@user.com',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      user =
        client.sessions.authenticate(
          email: 'test@user.com',
          password: '12345'
        )

      user.email.should eq('test@user.com')
    end
  end
end
