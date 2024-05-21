# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :destroy_category_image]

    # GET /Categories or /Categories.json
    def index
      @categories = Category.all
    end

    # GET /Categories/1 or /Categories/1.json
    def show
    end

    # GET /Categories/new
    def new
      @category = Category.new
    end

    # GET /Categories/1/edit
    def edit
    end

    # POST /Categories or /Categories.json
    def create
      @category = Category.new(category_params)
      @category.category_image.attach(category_params[:category_image])
      respond_to do |format|
        if @category.save
          format.html do
            redirect_to(administrate_category_url(@category), notice: "Category was successfully created.")
          end
          format.json { render(:show, status: :created, location: @category) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /Categories/1 or /Categories/1.json
    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html do
            redirect_to(administrate_category_url(@category), notice: "Category was successfully updated.")
          end
          format.json { render(:show, status: :ok, location: @category) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /Categories/1 or /Categories/1.json
    def destroy
      respond_to do |format|
        format.html do
          if @category.articles.count > 0
            redirect_to(
              administrate_categories_url,
              alert: "Category can not destroyed.",
            )
          else
            @category.destroy!
            redirect_to(administrate_categories_url, notice: "Category was successfully destroyed.")
          end
        end
        format.json { head(:no_content) }
      end
    end

    def destroy_category_image
      @category.category_image.purge

      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@category)) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :category_image)
    end
  end
end
