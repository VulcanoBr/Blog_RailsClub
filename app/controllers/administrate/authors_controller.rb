# frozen_string_literal: true

module Administrate
  class AuthorsController < AdministrateController
    before_action :set_author, only: [:show, :edit, :update, :destroy]

    # GET /Authors or /Authors.json
    def index
      @authors = Author.all
    end

    # GET /Authors/1 or /Authors/1.json
    def show
    end

    # GET /Authors/new
    def new
      @author = Author.new
    end

    # GET /Authors/1/edit
    def edit
    end

    # POST /Authors or /Authors.json
    def create
      @author = Author.new(author_params)

      respond_to do |format|
        if @author.save
          format.html do
            redirect_to(administrate_author_url(@author), notice: "Author was successfully created.")
          end
          format.json { render(:show, status: :created, location: @author) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /Authors/1 or /Authors/1.json
    def update
      respond_to do |format|
        if @author.update(author_params)
          format.html do
            redirect_to(administrate_author_url(@author), notice: "Author was successfully updated.")
          end
          format.json { render(:show, status: :ok, location: @author) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /Authors/1 or /Authors/1.json
    def destroy
      respond_to do |format|
        format.html do
          if @author.articles.count > 0
            redirect_to(
              administrate_authors_url,
              alert: "Author can not destroyed.",
            )
          else
            @author.destroy!
            redirect_to(administrate_authors_url, notice: "Author was successfully destroyed.")
          end
        end
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :description, :facebook_profile_url,
      :instagram_profile_url, :twitter_profile_url, :linkedin_profile_url,
      :youtube_profile_url, :_destroy)
    end
  end
end
