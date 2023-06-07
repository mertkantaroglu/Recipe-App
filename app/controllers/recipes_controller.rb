class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :recipe_created_notice, only: :create
  before_action :recipe_destroyed_notice, only: :destroy

  # GET /recipes or /recipes.json
  def index
    @recipes = current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe)}
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
    end

    def recipe_created_notice
      flash.now[:notice] = 'Recipe was successfully created.'
    end

    def recipe_destroyed_notice
      flash.now[:notice] = 'Recipe was successfully destroyed.'
    end
end
