# QuotesController manages all actions related to the Quote model.
# It provides full CRUD (Create, Read, Update, Delete) functionality and ensures
# proper authentication and authorization for sensitive actions.
class QuotesController < ApplicationController
  # This callback runs before show, edit, update, and destroy actions
  # to find the relevant quote and set it as @quote.
  before_action :set_quote, only: %i[ show edit update destroy ]

  # Restrict access to certain actions only to logged-in users.
  # index and show actions are public, so they are excluded.
  before_action :require_login, except: %i[ index show ] 

  # GET /quotes
  # Fetch all public quotes from the database, ordered by creation date (newest first)
  def index
    @quotes = Quote.where(is_public: true).order(created_at: :desc)
  end

  # GET /quotes/:id
  # Shows a single quote identified by its ID.
  # The @quote instance variable is set using the set_quote callback.
  def show
    @quote = Quote.find(params[:id])
  end

  # GET /quotes/new
  # Prepares a new quote object for the creation form.
  # Builds 3 initial fields for adding categories via nested attributes,allowing the user to select multiple categories for the quote.
  def new
      @quote = Quote.new
      # Build 3 initial fields for adding categories. This is enough for the prototype.
      5.times { @quote.quote_categories.build }
  end

  # GET /quotes/:id/edit
  # Prepares an existing quote for editing.
  # The @quote instance variable is set using the set_quote callback.
  def edit
      @quote = Quote.find(params[:id])
  end

  # POST /quotes
  # Handles the creation of a new quote with the submitted form data.
  # - If saving succeeds, redirects to the quote’s show page with a success notice.
  # - If saving fails due to validation errors, re-renders the new form with error messages.
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/:id
  # Updates an existing quote with the submitted form data.
  # - If updating succeeds, redirects to the quote’s show page with a success notice.
  # - If updating fails, re-renders the edit form so the user can correct errors.
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /quotes/:id
  # Deletes the quote from the database.
  # After deletion, redirects to the quotes list with a notice.
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Callback to find and set the quote based on the provided ID.
    # This avoids repeating the same code in show, edit, update, and destroy actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Strong parameters: only allows trusted parameters to be used for mass assignment.
    # This includes quote attributes as well as nested quote_categories attributes
    # for assigning categories to the quote..
    def quote_params
      params.require(:quote).permit(
        :quote_text,
        :published_year,
        :comment,
        :is_public,
        :user_id,
        :philosopher_id,
        quote_categories_attributes: [:id, :category_id, :_destroy]
      )
    end
end
