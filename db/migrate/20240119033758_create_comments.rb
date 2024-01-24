class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :first_name
      t.string :last_name
      t.string :comment
      #t.string :category

      t.timestamps
    end
  end
end
