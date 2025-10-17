class CategoriesController < ApplicationController
  # CategoriesController handles all actions related to the Category model.It provides standard CRUD (Create, Read, Update, Delete) functionality
  # and ensures proper setup and parameter handling for each action.

  # This callback runs before show, edit, update, and destroy actions.
  # It finds the category by its ID and sets it to @category, so these actions
  # can use it directly without repeating the code in each method.
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories
  # Lists all categories in the system.
  # The @categories instance variable will be available in the view for display.
  def index
    @categories = Category.all
  end

  # GET /categories/:id
  # Shows the details of a single category.
  # The @category instance variable is set by the set_category callback.
  def show
  end

  # GET /categories/new
  # Prepares a new Category object for the form in the view.
  # This does not save anything yet; it just allows the user to fill in details.
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  # Prepares an existing category for editing.
  def edit
  end

   # POST /categories
  # Handles the creation of a new category using the submitted form data.
  # - If saving succeeds, it redirects to the category's show page with a success notice.
  # - If saving fails due to validation errors, it re-renders the new form with error messages.
  # Responds to both HTML and JSON formats.
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/:id
  # Updates an existing category with the submitted form data.
  # - If updating succeeds, redirects to the category's show page with a success notice.
  # - If updating fails, re-renders the edit form with errors.
  # Responds to both HTML and JSON formats.
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/:id
  # Deletes the category from the database.
  # After deletion, redirects to the list of categories with a notice.
  # Responds to both HTML and JSON formats.
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, notice: "Category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.expect(category: [ :category_name ])
    end
end
