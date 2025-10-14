class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.text :quote_text, null: false 
      t.integer :published_year
      t.text :comment
      t.boolean :is_public, default: true
      t.references :user, null: false, foreign_key: true
      t.references :philosopher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
