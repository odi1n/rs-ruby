class CreateStatisticas < ActiveRecord::Migration[5.2]
  def change
    create_table :statisticas do |t|
      t.references :stock, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :much_was
      t.integer :much_was_left
      t.integer :realized
      t.decimal :revenue

      t.timestamps
    end
  end
end
