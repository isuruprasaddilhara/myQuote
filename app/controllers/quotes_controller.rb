class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: %i[ index show ] # 'index' and 'show' can be public
  #before_action :authorize_owner, only: [:edit, :update]

  # GET /quotes or /quotes.json
  def index
    if logged_in?
      @quotes = current_user.quotes
    else
      @quotes = Quote.where(is_public: true).order(created_at: :desc)
    end
  end

  # GET /quotes/1 or /quotes/1.json
  def show
    @quote = Quote.find(params[:id])
  end

  # GET /quotes/new
  def new
      @quote = Quote.new
      # Build 3 initial fields for adding categories. This is enough for the prototype.
      3.times { @quote.quote_categories.build }
  end

  # GET /quotes/1/edit
  def edit
      @quote = Quote.find(params[:id])
  end

  # POST /quotes or /quotes.json
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

  # PATCH/PUT /quotes/1 or /quotes/1.json
  # def update
  #   respond_to do |format|
  #     if @quote.update(quote_params)
  #       format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
  #       format.json { render :show, status: :ok, location: @quote }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @quote.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def update
    @quote = Quote.find(params[:id])
    if @quote.update(quote_params)
      redirect_to @quote, notice: 'Quote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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
