class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.string :state
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
