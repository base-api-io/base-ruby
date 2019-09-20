# frozen_string_literal: true

describe Base do
  context 'Listing forms' do
    it 'lists forms' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/forms/?page=1&per_page=10')
        .to_return(
          body: {
            items: [{
              created_at: Time.now.rfc2822,
              name: 'Test',
              id: 'id'
            }],
            metadata: {
              count: 1
            }
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      list =
        client.forms.list

      list.metadata.count.should eq(1)
    end
  end

  context 'Create a from' do
    it 'creates a form' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/forms/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'Test',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      form =
        client.forms.create(name: 'Test')

      form.name.should eq('Test')
      form.id.should eq('id')
    end
  end

  context 'Get a form' do
    it 'gets a forms' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/forms/form_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'Test',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      form =
        client.forms.get('form_id')

      form.name.should eq('Test')
      form.id.should eq('id')
    end
  end

  context 'Delete a form' do
    it 'deletes a form' do
      WebMock
        .stub_request(:delete, 'https://api.base-api.io/v1/forms/form_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'Test',
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      form =
        client.forms.delete('form_id')

      form.name.should eq('Test')
      form.id.should eq('id')
    end
  end

  context 'Submit a submission' do
    it 'creates a submission' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/forms/form_id/submit')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            files: [],
            fields: nil,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      tempfile =
        Tempfile.new

      submission =
        client.forms.submit(
          id: 'form_id',
          form: {
            file: tempfile,
            key: 'value'
          }
        )

      submission.files.should eq([])
      submission.fields.should eq(nil)
      submission.id.should eq('id')
    end
  end

  context 'Listing submissions' do
    it 'lists form submissions' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/forms/form_id/submissions?page=1&per_page=10')
        .to_return(
          body: {
            items: [{
              created_at: Time.now.rfc2822,
              files: [],
              fields: nil,
              id: 'id'
            }],
            metadata: {
              count: 1
            }
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      list =
        client.forms.submissions(id: 'form_id')

      list.metadata.count.should eq(1)
    end
  end

  context 'Get a form submission' do
    it 'gets a form submission' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/forms/form_id/submissions/id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            files: [],
            fields: nil,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      submission =
        client.forms.get_submission('form_id', 'id')

      submission.files.should eq([])
      submission.fields.should eq(nil)
      submission.id.should eq('id')
    end
  end

  context 'Delete a form' do
    it 'deletes a form' do
      WebMock
        .stub_request(:delete, 'https://api.base-api.io/v1/forms/form_id/submissions/id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            files: [],
            fields: nil,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      submission =
        client.forms.delete_submission('form_id', 'id')

      submission.files.should eq([])
      submission.fields.should eq(nil)
      submission.id.should eq('id')
    end
  end
end
