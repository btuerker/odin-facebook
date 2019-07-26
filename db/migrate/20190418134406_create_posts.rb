# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
