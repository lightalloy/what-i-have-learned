### Oauth 2.0
- an app redirects user to the auth page (the service)
- the user confirms that the access and permissions are ok
- service redirects the user to the app, the callback url that was specified
- the app makes an auth token request
- the service provides the token
- the token may be used for the interaction with the service

```ruby
require 'oauth2'
client = OAuth2::Client.new('client_id', 'client_secret', :site => 'https://example.org')

client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
# => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
response.class.name
# => OAuth2::Response
```
Apps that have only client part:
- an app redirects user to the auth page (the service)
- the user confirms that the access and permissions are ok
- redirect to a dummy page (the service, e.g. "http://connect.mail.ru/oauth/success.html#access_token=FJQbwq9&token_type=bearer&
            expires_in=86400&refresh_token=yaeFa0gu")
- the app gets a token from the dummy page url

An app also gets a refresh token, which can be used to get a new auth token via http request.




https://github.com/oauth-xx/oauth2
https://habr.com/company/mailru/blog/115163/
