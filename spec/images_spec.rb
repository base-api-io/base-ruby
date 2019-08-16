# frozen_string_literal: true

describe Base do
  context 'Create Image' do
    it 'creates an image' do
      WebMock
        .stub_request(:post, 'https://api.base-api.io/v1/images/')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'test.png',
            width: 100,
            height: 100,
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      image =
        client.images.create(image: Tempfile.new)

      image.name.should eq('test.png')
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq('id')
    end
  end

  context 'Get Image' do
    it 'gets a images details' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/images/image_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'test.png',
            width: 100,
            height: 100,
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      image =
        client.images.get('image_id')

      image.name.should eq('test.png')
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq('id')
    end
  end

  context 'Downloads Image' do
    it 'downloads the image' do
      WebMock
        .stub_request(:get, 'https://api.base-api.io/v1/images/image_id/version?')
        .to_return(
          body: 'TEST'
        )

      client =
        Base::Client.new(access_token: 'access_token')

      image =
        client.images.download('image_id')

      image.should respond_to('read')
      image.read.should eq('TEST')
    end
  end

  context 'Image URL' do
    it 'returns the process url of the image' do
      client =
        Base::Client.new(access_token: 'access_token')

      client
        .images
        .image_url('image_id')
        .should eq('https://api.base-api.io/v1/images/image_id/version?')
    end

    it 'returns the process url of the image with parameters' do
      client =
        Base::Client.new(access_token: 'access_token')

      client
        .images
        .image_url('image_id', quality: 80,
                               format: 'jpg',
                               resize: Base::Resize.new(width: 100,
                                                        height: 100),
                               crop: Base::Crop.new(height: 2,
                                                    width: 1,
                                                    left: 4,
                                                    top: 3))
        .should eq('https://api.base-api.io/v1/images/image_id/version?quality=80&format=jpg&resize=100_100&crop=1_2_4_3')
    end
  end

  context 'Delete Image' do
    it 'deletes an image' do
      WebMock
        .stub_request(:delete, 'https://api.base-api.io/v1/images/image_id')
        .to_return(
          body: {
            created_at: Time.now.rfc2822,
            name: 'test.png',
            width: 100,
            height: 100,
            size: 100,
            id: 'id'
          }.to_json
        )

      client =
        Base::Client.new(access_token: 'access_token')

      image =
        client.images.delete('image_id')

      image.name.should eq('test.png')
      image.height.should eq(100)
      image.width.should eq(100)
      image.size.should eq(100)
      image.id.should eq('id')
    end
  end
end
