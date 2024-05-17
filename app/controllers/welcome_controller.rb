# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.order(updated_at: :desc).limit(6)
  end
end
