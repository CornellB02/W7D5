class CreateSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.references :moderator, null: false, foreign_key: {to_table: :users}
      t.text :description
      t.timestamps
    end
    add_index :subs, :title
  end
end
