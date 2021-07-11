class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_type
      t.boolean :public
      t.references :repo, foreign_key: true
      t.references :actor, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
