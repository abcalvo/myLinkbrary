class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url, null: false, default: ""
      t.string :title, default: "No title"

      t.string :notes, default: ""

      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
