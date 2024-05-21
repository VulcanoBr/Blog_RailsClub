# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :articles, dependent: :nullify
  has_one_attached :category_image
end
