
JWT allows us to authenticate requests between the client and the server by encrypting authentication information into a compact JSON object.

JWT allows us to encrypt a user's identifying information, store it in a token, inside a JSON object, and include that object in every request that requires authentication.

Users login with jwt:
- user fills sign in form
- login and password are passed to the API
- backend app finds out if the user can be authed
- user's unique Id is encrypted with JWT into a JSON Web Token.
- This token is then included in the response that the backend app sends back to the frontend app.
- Frontend app stores the encrypted jwt token in session storage. It retreives it and sends back to the backend app when it needs to perform authenticated requests.

So the encrypted JWT is decrypted on the backend side.

Logout: frontend app removes the token from its store.

JWT tokens are encrypted in three parts:
- the header
- the payload
- the signature

```ruby
require 'jwt'

JWT.encode(payload, secret_key, algorithm)
# payload { user_id: 1 }
# secret key: generate and store at the backend, e.g. ENV['AUTH_SECRET']
# ALGORITHM = 'HS256'
```

Backend functionality:
- generating JWT on auth attempt `JWT.encode`
- getting a current_user
Frontend app will provide a following header:
`"HTTP_AUTHORIZATION" => "Bearer <super encoded JWT>"``
So: check if the header matches, get the token from it, decode the token, find the user with corresponding id
- 



http://www.thegreatcodeadventure.com/jwt-auth-in-rails-from-scratch/

https://github.com/jwt/ruby-jwt

https://www.infoq.com/news/2010/01/rest-api-authentication-schemes