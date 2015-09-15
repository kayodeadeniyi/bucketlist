class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done

  # belongs_to :bucketlist


  attribute :created_at, :key => :date_created
  attribute :updated_at, :key => :date_modified
end
