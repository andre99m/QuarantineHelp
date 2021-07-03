class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :imagePath
      t.string :title
      t.string :description
      t.string :category
      t.timestamps
    end
  end
end
