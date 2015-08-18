class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :status
      t.string :link

      t.timestamps
    end
  end
end
