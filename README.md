# Base

Ruby client for the [Base API](https://www.base-api.io) service, with it you
can manage authentication, email sending, files and images of your application.

## Installation

### Using RubyGems

Just run this command: `gem install base-api-io`

### Using Bundler

1. Add the dependency to your `Gemfile`:

   ```ruby
   gem 'base-api-io', '~> 1.0.0'
   ```

2. Run `bundle install`

## Usage

1. Sign up on [www.base-api.io](https://www.base-api.io) and create an
   application and copy its access token.

2. Require the shard:

   ```ruby
   require 'base'
   ```

3. Create a client:

   ```ruby
   client =
     Base::Client.new(access_token: "your_access_token")
   ```

### Sending email

Using the `emails` endpoint on the client you can send emails:

```ruby
# Sending an email
email =
  client.emails.send(
    from: "from@example.com",
    to: "to@example.com",
    subject: "Test Email",
    html: "<b>Html message</b>",
    text: "Text message")
```

### Users

Using the `users` endpoint  on the client you can create / get or delete users:

```ruby
# Create a user with email / password
user =
  client.users.create(
    email: "test@user.com",
    confirmation: "12345",
    password: "12345")

# Get a users details by the id
user =
  client.users.get("user_id")

# Delete a user by id
user =
  client.users.delete("user_id")
```

### Sessions

Using the `sessions` endpoint on the client you can authenticate a user.

```ruby
# Create a user with email / password
user =
  client.sessions.authenticate(
    email: "test@user.com",
    password: "12345")
```

### Forgot Password Flow

Using the `passwords` endpoint on the client you can perform a forgot password flow.

```ruby
# Create an forgot password token for the user with the given email address.
token =
  client.passwords.forgot_password(email: "test@user.com")

# Using that token set a new password.
user =
  client.passwords.set_password(
    forgot_password_token: token.forgot_password_token,
    confirmation: "123456",
    password: "123456")
```

### Files

Using the `files` endpoint on the client you can create / get / delete or
download files:

```ruby
# Create a file
file =
  client.files.create(file: File.open("/path/to/file"))

# Get a file by id
file =
  client.files.get("file_id")

# Delete a file by id
file =
  client.files.delete("file_id")

# Get a download URL to the file by id
url =
  client.files.download_url("file_id")

# Download the file by id into an IO
io =
  client.files.download("file_id")
```

### Images

Using the `images` endpoint on the client you can create / get / delete or
process images:

```ruby
# Create an image
image =
  client.images.create(image: File.open("/path/to/image"))

# Get a image by id
image =
  client.images.get("image_id")

# Delete a image by id
image =
  client.images.delete("image_id")

# Get a link to a prcessed version (crop & resize) of the image by id
url =
  client.images.image_url(i.id,
    crop: Base::Crop.new(width: 100, height: 100, top: 0, left: 0),
    resize: Base::Resize.new(width: 100, height: 100),
    format: "jpg",
    quality: 10)
```

## Development

This library uses [Faraday](https://lostisland.github.io/faraday/), you can run the
specs locally with `rspec`.

## Contributing

1. Fork it (<https://github.com/base-api-io/base-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Gusztav Szikszai](https://github.com/gdotdesign) - creator and maintainer
