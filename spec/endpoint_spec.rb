# frozen_string_literal: true

describe Base do
  context 'Successfull request' do
    it 'returns response' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1//')
        .to_return(body: 'BODY')

      endpoint =
        Base::Endpoint.new(
          access_token: 'access_token',
          url: 'https://api.base-api.io'
        )

      response =
        endpoint.request do
          endpoint.connection.get
        end

      response.body.should eq('BODY')
    end
  end

  context 'Unauthorized' do
    it 'raises an error' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1//')
        .to_return(
          status: 401,
          body: ''
        )

      endpoint =
        Base::Endpoint.new(
          access_token: 'access_token',
          url: 'https://api.base-api.io'
        )

      expect do
        endpoint.request do
          endpoint.connection.get
        end
      end.to raise_error(Base::Unauthorized)
    end
  end

  context 'Some unkown error' do
    it 'raises an error' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1//')
        .to_return(
          status: 401,
          body: ''
        )

      endpoint =
        Base::Endpoint.new(
          access_token: 'access_token',
          url: 'https://api.base-api.io'
        )

      expect do
        endpoint.request do
          raise 'TEST'
        end
      end.to raise_error(Base::UnkownError)
    end
  end

  context 'Invalid Request' do
    it 'raises an error' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1//')
        .to_return(
          status: 422,
          body: {
            error: 'ERROR',
            data: {}
          }.to_json
        )

      endpoint =
        Base::Endpoint.new(
          access_token: 'access_token',
          url: 'https://api.base-api.io'
        )

      expect do
        endpoint.request do
          endpoint.connection.get
        end
      end.to raise_error(Base::InvalidRequest)
    end
  end
end
