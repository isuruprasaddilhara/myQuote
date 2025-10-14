class CreatePhilosophers < ActiveRecord::Migration[8.0]
  def change
    create_table :philosophers do |t|
      t.string :fname
      t.string :lname
      t.integer :birth_year
      t.integer :death_year
      t.text :short_bio

      t.timestamps
    end
  end
end
