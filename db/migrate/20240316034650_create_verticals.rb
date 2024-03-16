class CreateVerticals < ActiveRecord::Migration[7.1]
  def change
    create_table :verticals do |t|
      t.string :name

      t.timestamps
    end
  end
end
