class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :vertical, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
