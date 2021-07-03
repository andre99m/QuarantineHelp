class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :emailuser
      t.string :cartTitoli, array: true
      t.string :cartQuantita, array: true
      t.string :stato
      t.string :emailassistente
      t.string :rifiuti, array: true
      t.string :indirizzo
      t.timestamps
    end
  end
end
