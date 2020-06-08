# frozen_string_literal: true

class CreatePicposts < ActiveRecord::Migration[5.2]
  def change
    create_table :picposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :picposts, %i[user_id created_at]
  end
end
