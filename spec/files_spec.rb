# frozen_string_literal: true

describe Base do
  context 'Listing Files' do
    it 'returns a list of files' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/files/?page=1&per_page=10')
        .to_return(
          body: {
            items: [{
              created_at: Time.now.rfc2822,
              extension: 'png',
              name: 'test.png',
              size: 100,
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
        client.files.list

      data.metadata.count.should eq(1)
      data.items.length.should eq(1)
    end
  end

  context 'Create File' do
    it 'creates a file' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/files/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            extension: 'png',
            name: 'test.png',
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      tempfile =
        Tempfile.new

      file =
        client.files.create(
          filename: 'test.text',
          path: tempfile.path,
          type: 'text/plain'
        )

      file.extension.should eq('png')
      file.name.should eq('test.png')
      file.size.should eq(100)
      file.id.should eq('id')
    end
  end

  context 'Get File' do
    it 'gets a files details' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/files/file_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            extension: 'png',
            name: 'test.png',
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      file =
        client.files.get('file_id')

      file.extension.should eq('png')
      file.name.should eq('test.png')
      file.size.should eq(100)
      file.id.should eq('id')
    end
  end

  context 'Downloads File' do
    it 'downloads the file' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/files/file_id/download')
        .to_return(
          body: 'TEST'
        )

      client =
        Base::Client.new(access_token: 'access_token')

      file =
        client.files.download('file_id')

      file.should respond_to('read')
      file.read.should eq('TEST')
    end
  end

  context 'Downloads URL' do
    it 'returns the download url of the file' do
      client =
        Base::Client.new(access_token: 'access_token')

      client
        .files
        .download_url('file_id')
        .should eq('https://api.base-api.io/v1/files/file_id/download')
    end
  end

  context 'Delete File' do
    it 'deletes a file' do
      WebMock
        .stub_request(:delete, 'https://api.base-api.io/v1/files/file_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            extension: 'png',
            name: 'test.png',
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      file =
        client.files.delete('file_id')

      file.extension.should eq('png')
      file.name.should eq('test.png')
      file.size.should eq(100)
      file.id.should eq('id')
    end
  end
end
