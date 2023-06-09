class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]

  # GET /recipe_foods or /recipe_foods.json
  def index
    @recipe_foods = RecipeFood.all
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show; end

  # GET /recipe_foods/new
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = RecipeFood.new
  end

  # GET /recipe_foods/1/edit
  def edit; end

  # POST /recipe_foods or /recipe_foods.json
  def create
    recipe_id = params[:recipe_id]
    foods = params[:add_food] || []
    quantities = params[:quantity] || []

    foods.each_with_index do |food_id, _index|
      quantity = quantities[food_id.to_s].to_i

      # Check if a recipe_food record already exists with the same recipe_id and food_id
      @recipe_food = RecipeFood.find_or_initialize_by(recipe_id:, food_id:)

      # If the record already exists, update its quantity attribute
      if @recipe_food.persisted?
        @recipe_food.update(quantity: @recipe_food.quantity + quantity)
      else
        # Otherwise, create a new recipe_food record with the given attributes
        @recipe_food.quantity = quantity

        if @recipe_food.save
          flash[:notice] = 'Recipe added successfully!'
        else
          flash[:alert] = "Couldn't add recipe. Please try again."
          render :new, status: :unprocessable_entity
        end
      end
    end

    redirect_to "/recipes/#{recipe_id}"
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  # def update
  #   respond_to do |format|
  #     if @recipe_food.update(recipe_food_params)
  #       format.html { redirect_to recipe_food_url(@recipe_food), notice: "Recipe food was successfully updated." }
  #       format.json { render :show, status: :ok, location: @recipe_food }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food = RecipeFood.includes(:food).find_by(id: params[:id], recipe_id: params[:recipe_id])

    if @recipe_food&.destroy
      flash[:success] = 'ingredient Removed!'
    else
      flash[:danger] = 'Sorry Failed To Remove Ingredient!'
    end
    redirect_to request.referrer
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  #   # Only allow a list of trusted parameters through.
  #   def recipe_food_params
  #     params.require(:recipe_food).permit(:quantity)
  #   end
end
