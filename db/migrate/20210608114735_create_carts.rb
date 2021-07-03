class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.string 'emailuser'
      t.string 'title'
      t.integer 'quantity'
      t.integer 'iduser'
      t.string 'description'
      t.string 'imagePath'
      t.timestamps
    end
  end
end
