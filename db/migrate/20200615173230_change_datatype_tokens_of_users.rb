# frozen_string_literal: true

class ChangeDatatypeTokensOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :tokens, 'json USING tokens::json'
  end
end
