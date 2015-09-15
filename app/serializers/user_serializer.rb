class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :auth_token

end
