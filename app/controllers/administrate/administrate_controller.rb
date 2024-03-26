# fronze_string_literal: true 
module Administrate
  class AdministrateController < ApplicationController

    before_action :authenticate_admin!

    layout "administrate"

  end
end