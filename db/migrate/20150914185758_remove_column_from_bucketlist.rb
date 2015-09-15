class RemoveColumnFromBucketlist < ActiveRecord::Migration
  def change
    remove_column :bucketlists, :created_by, :string
  end
end
