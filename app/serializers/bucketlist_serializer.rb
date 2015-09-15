class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :user

  # belongs_to :user
  # has_many :items

  # attribute :created_at, :key => :date_created
  # attribute :updated_at, :key => :date_modified

  def user
    object.user.name
  end

  has_many :items

  attribute :created_at, :key => :date_created
  attribute :updated_at, :key => :date_modified

end
