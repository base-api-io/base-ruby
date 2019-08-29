# frozen_string_literal: true

describe Base do
  context 'Listing Users' do
    it 'returns a list of users' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/users/?page=1&per_page=10')
        .to_return(
          body: {
            items: [{
              created_at: Time.now.rfc2822,
              email: 'test@user.com',
              id: 'id'
            }],
            metadata: {
              count: 1
            }
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      data =
        client.users.list

      data.metadata.count.should eq(1)
      data.items.length.should eq(1)
    end
  end

  context 'Create User' do
    it 'creates a user' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/users/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            email: 'test@user.com',
            custom_data: 'test',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      user =
        client.users.create(
          email: 'test@user.com',
          confirmation: '12345',
          custom_data: 'test',
          password: '12345'
        )

      user.email.should eq('test@user.com')
      user.created_at.should be_a(Time)
      user.id.should eq('id')
    end
  end

  context 'Update User' do
    it 'updates a user' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/users/user_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            email: 'test@user.com',
            custom_data: 'test',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      user =
        client.users.update(
          id: 'user_id',
          email: 'test@user.com',
          custom_data: 'test'
        )

      user.email.should eq('test@user.com')
      user.created_at.should be_a(Time)
      user.id.should eq('id')
    end
  end

  context 'Get User' do
    it 'gets a users details' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/users/user_id')
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
        client.users.get('user_id')

      user.email.should eq('test@user.com')
      user.created_at.should be_a(Time)
      user.id.should eq('id')
    end
  end

  context 'Delete User' do
    it 'deletes a users' do
      WebMock
        .stub_request(:delete, 'https://api.base-api.io/v1/users/user_id')
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
        client.users.delete('user_id')

      user.email.should eq('test@user.com')
      user.created_at.should be_a(Time)
      user.id.should eq('id')
    end
  end
end
