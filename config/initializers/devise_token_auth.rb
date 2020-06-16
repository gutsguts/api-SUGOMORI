# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false

  config.token_lifespan = 1.month

  config.headers_names = { 'access-token': 'access-token',
                           client: 'client',
                           expiry: 'expiry',
                           uid: 'uid',
                           'token-type': 'token-type' }
end
