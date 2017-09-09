class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    @expenses = Expense.all
    
    if @setting = Setting.order("created_at").last == nil  
      @setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol)
    else
      @setting = Setting.order("created_at").last
    end
  end
  
  # GET /categories/1
  # GET /categories/1.json
  def show
    @category_expenses = @category.expenses
    if @setting = Setting.order("created_at").last == nil  
      @setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol)
    else
      @setting = Setting.order("created_at").last
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def create_basic_categories
    
    @basic_categories = ["Bills", "Clothes", "Food", "House"]
    
    @basic_categories.each do |basic_categories|
    @category = Category.create(name: basic_categories, user: current_user)
    

    end
    
    redirect_to root_path
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

end
