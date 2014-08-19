class UpdateComments < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer, default: nil
  	add_column :comments, :post_id, :integer, default: nil
  end
end
