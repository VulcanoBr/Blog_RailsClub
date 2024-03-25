module Administrate
  class DashboardsController < ApplicationController
    before_action :authenticate_admin!

    layout "administrate"

    def index

    end
  end
end