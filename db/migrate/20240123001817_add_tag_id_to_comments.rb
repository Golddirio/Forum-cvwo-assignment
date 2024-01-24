class AddTagIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :tag_id, :integer
  end
end
