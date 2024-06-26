# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.includes(:category, :author).order(updated_at: :desc).limit(6)
    @categories = Category.limit(8)
  end
end
