# frozen_string_literal: true

class Picpost < ApplicationRecord
  # belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
