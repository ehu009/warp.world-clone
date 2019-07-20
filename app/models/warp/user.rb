class Warp::User < ApplicationRecord
  has_many :levels
  attr_encrypted :encrypted_api_key, key: 666666666666
end
