# frozen_string_literal: true

describe Base do
  context 'Forgot Password' do
    it 'creates a forgot password token' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/password/')
        .to_return(
          body: {
            forgot_password_token: 'token'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      token =
        client.passwords.forgot_password(
          email: 'test@user.com'
        )

      token.forgot_password_token.should eq('token')
    end
  end

  context 'Setting password with token' do
    it 'creates a forgot password token' do
      WebMock
        .stub_request(:put, 'https://api.base-api.io/v1/password/')
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
        client.passwords.set_password(
          forgot_password_token: 'token',
          confirmation: '12345',
          password: '12345'
        )

      user.email.should eq('test@user.com')
    end
  end
end
