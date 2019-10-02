# frozen_string_literal: true

describe Base do
  context 'Listing Emails' do
    it 'returns a list of emails' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/emails/?page=1&per_page=10')
        .to_return(
          body: {
            items: [{
              created_at: Time.now.rfc2822,
              from_address: 'test@user.com',
              to_address: 'test@user.com',
              subject: 'subject',
              html: 'html',
              text: 'text',
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
        client.emails.list

      data.metadata.count.should eq(1)
      data.items.length.should eq(1)
    end
  end

  context 'Sending Emails' do
    it 'creates an email log' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/emails/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            from_address: 'test@user.com',
            to_address: 'test@user.com',
            subject: 'subject',
            html: 'html',
            text: 'text',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      token =
        client.emails.send(
          from: 'test@user.com',
          to: 'test@user.com',
          subject: 'subject',
          html: 'html',
          text: 'text'
        )

      token.from_address.should eq('test@user.com')
      token.to_address.should eq('test@user.com')
      token.subject.should eq('subject')
      token.html.should eq('html')
      token.text.should eq('text')
    end
  end
end
