class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name, null: false

      t.belongs_to :user, index: true

      t.timestamps null: false

    end

    add_index :tags, [ :tag_name, :user_id ], unique: true

    create_join_table :tags, :links
  end
end
